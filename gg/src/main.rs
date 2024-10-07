use clap::{Parser, Subcommand};
use xshell::{cmd, Shell};

#[derive(Parser)]
#[command(version, about, long_about = None)]
struct Args {
    #[command(subcommand)]
    command: Commands,
}

#[derive(Subcommand)]
enum Commands {
    Log,
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
}
