use anyhow::Result;

#[tokio::test]
async fn quick_dev() -> Result<()> {
    let hc = https_test::new_client("http://localhost:8080")?;
    hc.do_get("/hello?name=Nikolay").await?.print().await?;
    Ok(())
}
