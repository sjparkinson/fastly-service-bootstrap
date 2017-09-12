# Fastly Service Bootstrap

Project framework for a Fastly service configured with Terraform.

To run locally have the following exported in your environment.

```shell
export FASTLY_SERVICE_ID=
export FASTLY_SERVICE_HOST=
export FASTLY_API_KEY=
```

How to limit to one master deploy at a time in CircleCI, https://discuss.circleci.com/t/serializing-deployments/153.

~Caching the Terraform state file between deploys, https://circleci.com/docs/2.0/caching/.~, no need for a Fastly only configuration we can just import the state on every build and keep it simple.

Passing the plan between CircleCI jobs in the workflow, https://circleci.com/docs/2.0/workflows/#using-workspaces-to-share-data-among-jobs.

Display plan for manual approval before production deploy.

Running Terraform in CircleCI, https://www.terraform.io/guides/running-terraform-in-automation.html.

Making a good Makefile, http://nullprogram.com/blog/2017/08/20/.
