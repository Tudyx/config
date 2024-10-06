use xshell::{cmd, Shell};

pub fn run(sh: &Shell) -> anyhow::Result<()> {
    let tmp_dir = sh.create_temp_dir()?;
    sh.change_dir(tmp_dir.path());
    cmd!(sh, "cargo new playground").run()?;
    std::mem::forget(tmp_dir);
    println!(
        "{}/playground",
        sh.current_dir()
            .as_path()
            .to_str()
            .ok_or_else(|| anyhow::anyhow!("wrong playground path"))?
    );
    Ok(())
}
