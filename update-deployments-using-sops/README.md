This is the automation file for github actions. This includes 3 Steps:

1) Authentication of Gcloud and building the image from latest code pushed in repo.
   While building image we are using SOPs.
   
   SOPs are used to encrypt and decrypt secrets. Now we can push our secrets.yaml file in our repo with the help of SOPs. When new image will be build it automatically decrypts it and store that in .env file.
   It can be done with master key which we have stored in a secure KMS. We have to provide the path of our KMS where master key is stored.

2) Pushing the latest image in GCR.

3) Updating the Deployment with latest image in GKE.
