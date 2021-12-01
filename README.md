# Harmony DBT Project

Curated SQL Views and Metrics for the Harmony Blockchain.

What's Harmony? Learn more [here](https://www.harmony.one/)

## Getting Started

1. [PREREQUISITE] Download [Docker for Desktop](https://www.docker.com/products/docker-desktop).
2. Create a `.env` file with the following contents (note `.env` will not be commited to source):

```
SF_ACCOUNT="zsniary-metricsdao"
SF_USERNAME="<your_metrics_dao_snowflake_username>"
SF_PASSWORD="<your_metrics_dao_snowflake_password>"
SF_REGION="us-east-1"
SF_DATABASE="HARMONY"
SF_WAREHOUSE="DEFAULT"
SF_ROLE="PUBLIC"
SF_SCHEMA="DEV"
```

3. New to DBT? It's pretty dope. Read up on it [here](https://www.getdbt.com/docs/)

## Make Commands

Run the follow commands from inside the Harmony directory (**you must complete the Getting Started steps above^^**)

`make dbt-console`
This will mount your local harmony directory into a dbt console where dbt is installed.

`make dbt-docs`
This will compile your dbt documentation and launch a web-server at http://localhost:8080

### More DBT Resources:

- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices
