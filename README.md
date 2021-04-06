# Terraform GCP Modules Template

This repo is setup to be a template for easy creation of [Terraform Registry](https://registry.terraform.io/namespaces/teamdatatonic) modules

## Prerequisites
- [Terraform](https://tfswitch.warrensbox.com/) 
- [Commitizen](https://github.com/commitizen/cz-cli)
- [precommit](https://pre-commit.com/)

## To create a new repo

First create a new gitlab project in the folder: `https://gitlab.com/datatonic/templates/terraform-gcp-modules`

### 1. Clone the repo
```
git clone git@gitlab.com:datatonic/templates/terraform-gcp-modules-template.git
```

### 2. Remove old git state and add a new remote
```
rm -rf .git
git remote add origin {GIT_REPO_URL}
```

### 3. Update `go.mod` and Commitizen

First add module name on line 1 of `test/src/go.mod.example`
```
mv test/src/go.mod.example test/src.go.mod
```

Initialise commitizen
```
commitizen init cz-conventional-changelog --save-dev --save-exact --force
```

### 4. Update Readme, terraform versions
Remove template readme and create a new version
```
touch README.md
```

Now update the `gcp` and `gcp-beta` versions in `version.tf.sample`
```
mv version.tf.sample version.tf
```

### 5. Install pre-commit and CICD
Setup CICD
```
mv .gitlab-ci.yml.template .gitlab-ci.yml
```

Install pre-commit. First uncomment the `terraform_docs` section of the `.pre-commit-config.yml`. Then run:
```
pre-commit install
```

### 5. Git commit the initial commit
```
cz -s
```

### 6. Push to repo
```
git push -u origin master
```


## Updates

This template is a work in progress, if you go through and see anything that would make onboarding easier for the next developer, please create a MR and update! :) 
