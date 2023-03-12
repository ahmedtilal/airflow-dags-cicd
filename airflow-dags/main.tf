data "external" "env_vars" {
  program = ["${path.module}/env.sh"]
}

module "airflow_dags" {
  source = "../"
  github_token = data.external.env_vars.result["github_token"]
  repository_name = "demo-airflow-dags"
  repository_owner = "ahmedtilal"
  repository_branch = "master"
}