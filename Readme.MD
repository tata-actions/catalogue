building docker image and pushing to ECR.

3 steps :

   -> aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin         319255955334.dkr.ecr.us-east-1.amazonaws.com

   -> docker build -t 319255955334.dkr.ecr.us-east-1.amazonaws.com/roboshop/catalogue:latest .

   -> docker push 319255955334.dkr.ecr.us-east-1.amazonaws.com/roboshop/catalogue:latest 

 * In jenkins u need to download AWS plugin ---->AWS STEPS (for aws credentials)
 * which will help to access credentials of amazon to enter into it access ECR to store docker image after buiding and tagging with respective name. 


 Trivy download:
 curl -sfL https://raw.githubusercontent.com/aquasecurity/trivy/main/contrib/install.sh | sudo sh -s -- -b /usr/local/bin v0.68.2

 JENKINS FILE:

 jenkins_pipeline_behavior:
  - Uses Jenkins Shared Library named "jenkins-shared-library"
  - Loads reusable pipeline logic from centralized Git repository
  - Defines project configuration using key-value map:
      - project: roboshop
      - component: catalogue
  - Reads current Git branch using environment variable BRANCH_NAME
  - Executes CI pipeline only when branch is NOT "main"
  - Calls shared library function nodeJSEKSPipeline for non-main branches
  - Runs automated CI steps such as build, test, and image creation (library-defined)
  - Blocks pipeline execution on "main" branch
  - Requires Change Request (CR) or manual approval process for main branch
  - Prevents accidental production deployments from main branch