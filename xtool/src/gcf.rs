use anyhow::Context;
use xshell::{cmd, Shell};
// Git create fork ?
// Heavily inspired from https://github.com/matklad/config/blob/master/xtool/src/gcf.rs

pub fn run(sh: &Shell, repository: String) -> anyhow::Result<()> {
    let (user, repo) = repository.split_once('/').context("invalid user/repo")?;

    cmd!(sh, "git clone git@github.com:Tudyx/{repo}.git").run()?;
    let _p = sh.push_dir(repo);
    cmd!(
        sh,
        "git remote add upstream git@github.com:{user}/{repo}.git"
    )
    .run()?;
    cmd!(sh, "git fetch upstream").run()?;
    let branch = cmd!(sh, "git rev-parse --abbrev-ref HEAD").read()?;
    cmd!(sh, "git switch {branch}").run()?;
    cmd!(sh, "git reset --hard upstream/{branch}").run()?;
    cmd!(sh, "git branch --set-upstream-to=upstream/{branch}").run()?;

    Ok(())
}
