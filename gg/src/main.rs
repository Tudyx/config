use clap::{Parser, Subcommand};
use xshell::{cmd, Shell};

// Git helper, strongly inspired from
// https://github.com/matklad/config/blob/0f690f89c80b0e246909b54a0e97c67d5ce6ab0c/gg/src/main.rs

#[derive(Parser)]
#[command(version, about, long_about = None)]
struct Args {
    #[command(subcommand)]
    command: Commands,
}

#[derive(Subcommand)]
enum Commands {
    Log,
    Prune,
    Rebase,
    Create {
        /// The name of the branch to create
        branch: String,
    },
    Amend,
}

fn main() -> anyhow::Result<()> {
    let sh = Shell::new()?;
    let args = Args::parse();

    let main_branch = {
        let branches = cmd!(sh, "git branch")
            .read()
            .unwrap_or_else(|_| String::from("master"));
        if branches.contains(" master") {
            "master"
        } else {
            "main"
        }
    };

    let remote = {
        let remotes = cmd!(sh, "git remote")
            .read()
            .unwrap_or_else(|_| String::from("origin"));
        if remotes.contains("upstream") {
            "upstream"
        } else {
            "origin"
        }
    };
    let context = Context {
        sh: &sh,
        main_branch,
        remote,
    };

    match args.command {
        Commands::Log => context.log(),
        Commands::Prune => context.prune(),
        Commands::Rebase => context.rebase(),
        Commands::Create { branch } => context.create(branch),
        Commands::Amend => context.ammend(),
    }
}

struct Context<'a> {
    sh: &'a Shell,
    main_branch: &'static str,
    remote: &'static str,
}

impl<'a> Context<'a> {
    fn log(&self) -> anyhow::Result<()> {
        let remote = self.remote;
        let main_branch = self.main_branch;
        cmd!(self.sh, "git log --oneline {remote}/{main_branch}^..").run()?;
        Ok(())
    }

    fn prune(&self) -> anyhow::Result<()> {
        let branches = cmd!(self.sh, "git branch --merged").read()?;
        let branches: Vec<_> = branches
            .lines()
            .map(str::trim)
            .filter(|&it| {
                !(it == "master" || it == "main" || it.starts_with('*') || it.starts_with('+'))
            })
            .collect();
        if branches.is_empty() {
            println!("no merged branches");
            return Ok(());
        }

        cmd!(self.sh, "git branch -D {branches...}").run()?;
        Ok(())
    }

    fn rebase(&self) -> anyhow::Result<()> {
        let remote = self.remote;
        let main_branch = self.main_branch;
        cmd!(self.sh, "git fetch {remote} {main_branch}").run()?;
        cmd!(self.sh, "git rebase {remote}/{main_branch}").run()?;
        Ok(())
    }

    fn create(&self, branch: String) -> anyhow::Result<()> {
        let remote = self.remote;
        let main_branch = self.main_branch;
        cmd!(self.sh, "git fetch {remote} {main_branch}").run()?;
        cmd!(self.sh, "git switch --create {branch}").run()?;
        cmd!(self.sh, "git reset --hard {remote}/{main_branch}").run()?;
        Ok(())
    }

    fn ammend(&self) -> anyhow::Result<()> {
        let current_user = cmd!(self.sh, "git config --get user.name").read()?;
        let previous_commit_author = cmd!(self.sh, "git log --format=%aN -n 1 HEAD").read()?;
        if current_user != previous_commit_author {
            return Err(anyhow::anyhow!("The previous author '{previous_commit_author}' is different from the current user '{current_user}'"));
        }

        cmd!(self.sh, "git commit --amend --no-edit").run()?;
        Ok(())
    }
}
