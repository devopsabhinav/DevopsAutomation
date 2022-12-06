This is the automation file for Cloud Build present in GCP.
It is divided in 3 parts:

1) It is building the image whenever changes are pushed in github repo

2) In second step, it pushes that iamge to GCR.

3) In third step it uses a private worker pool to deploy that image in a private GKE cluster.
