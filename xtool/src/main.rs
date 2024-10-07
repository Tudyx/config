use clap::{Parser, Subcommand};
use xshell::Shell;

mod gcf;
mod playground;

#[derive(Parser)]
#[command(version, about, long_about = None)]
struct Args {
    #[command(subcommand)]
    command: Commands,
}

#[derive(Subcommand)]
enum Commands {
    /// Clone and setup a fork.
    Gcf {
        /// The user and repository of the forked repository, separated by a `/`.
        /// For instance rustls/pemfile
        respository: String,
    },
    /// Create a cargo project in tmp dir
    Playground,
}

fn main() -> anyhow::Result<()> {
    let sh = Shell::new()?;
    let args = Args::parse();
    match args.command {
        Commands::Gcf { respository } => gcf::run(&sh, respository),
        Commands::Playground => playground::run(&sh),
    }
}
