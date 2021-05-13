# Jenkins Pipeline Demo

This project is a demo for a multibranch pipeline on Jenkins. The demo
implements two Jenkins pipelines, `build-pipeline` and `deploy-pipeline`,
and together compose the whole CI/CD process of four stages for a web
application: build, test, containerize and deploy.

Each pipeline is triggered by different events:

- `build-pipeline`: It's triggered when a Pull Request is opened for any branch.
This event runs the first three stages of the CI/CD process before allowing
to merge a branch.

- `deploy-pipeline`: It's triggered when merging any branch into `development`.
This event runs all the stages of the process, from building to deployment.

## Jenkins on Docker

If you want to run a Jenkins instance on Docker, you need to configure your
Docker environment as described below. Otherwise, you can ignore these steps.

1. Install [Sysbox](https://github.com/nestybox/sysbox) container runtime:

    ```bash
    ./config/sysbox-install.sh
    ```

    See [Easy Jenkins with a System Container](https://blog.nestybox.com/2019/09/29/jenkins.html)
    for more information about how to run Jenkins on Docker
    properly for building Docker images.

2. Build custom container image for running Jenkins on Docker with `Sysbox`
runtime:

    ```bash
    docker build -t jenkins-sysbox config/jenkins
    ```

3. Run Jenkins:

    ```bash
    docker run -d --runtime=sysbox-runc --name jenkins -p 8080:8080 -p 50000:50000 jenkins-sysbox
    ```

## GitHub

### Webhooks

1. Go to your GitHub repository and click on `Settings`.
2. Click on Webhooks and then click on `Add webhook`.
3. In the `Payload URL` field, paste your Jenkins environment URL. At the end
of this URL add `/github-webhook/`.
4. For `Content type` select `application/json`.
5. Leave the `Secret` field empty.
6. In the subsection `Which events would you like to trigger this webhook?`
choose `Let me select individual events.` Then, check `Pull Requests` and
`Pushes`.

## Jenkins

### Credentials and Environment Variables

- Add your Docker Hub (if using a private repository) and SSH credentials of the
deployment server in the Jenkins credentials manager. See
[Using credentials](https://www.jenkins.io/doc/book/using/using-credentials) for
more information.

- In order to avoid hard-coding IP adressess of your deployment servers, you
can add environment variables such as the `$SSH_DEV_SERVER` used in this demo.
See [How To Set Jenkins Pipeline Environment Variables?](https://www.lambdatest.com/blog/set-jenkins-pipeline-environment-variables-list)
for more information.

### Plugins

In addition to the default plugins installed on Jenkins, the following are
required:

- [Docker](https://plugins.jenkins.io/docker-plugin)
- [Docker Pipeline](https://plugins.jenkins.io/docker-workflow)
- [Job and Stage Monitoring](https://plugins.jenkins.io/github-autostatus)
(Optional)

### Pipelines

#### Build Pipeline

1. Click on `New Item`.
2. Enter `build-pipeline` as item name and select `Multibranch Pipeline`.
3. Go to `Branch Sources` tab and add Github as source.
4. For private repositories, add GitHub credentials using your username and
personal access token.
5. Add repository URL.
6. In `Behaviours` subsection, select `Only branches that are also filed as PRs`.
7. Go to `Build Configuration` and in the `Script Path` field set the value
`cicd/Jenskinsfile`.
8. Click on `Save`.

#### Deploy Pipeline

1. Click on `New Item`.
2. Enter `build-pipeline` as item name and select `Multibranch Pipeline`.
3. Go to `Branch Sources` tab and add Github as source.
4. For private repositories, add GitHub credentials using your username and
personal access token.
5. Add repository URL.
6. In `Behaviours` subsection, select `All branches`.
7. Add new behaviour and select `Filter by name (with wildcards)`.
8. Leave the `include` field as it is and set `feature*` for `exclude`.
9. Go to `Build Configuration` and in the `Script Path` field set the value
`cicd/Jenskinsfile`.
10. Click on `Save`.
