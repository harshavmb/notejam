# notejam
This notejam presents the task given by NordCloud team

## What does notejam do?

Notejam is a web application which allows user to sign up/in/out and create/view/edit/delete notes. Notes can be grouped in pads.

## What is done as part of assessment?

A docker image is built using python code from scratch. The image has been pushed to internal dockerhub repository. Can show it in the demo :) Nevertheless, the dummy image in Dockerfile and Jenkinsfile could be replaced with a rhel7/centos7 image and the application could be built

Integrated with Jenkins CI to continuosly build the docker image when the code changes. By any chance if we have demo, I'll finish the CD part too (have the deploy, service and ingress yaml files locally :))

Added the deploy, service and nginx yaml configuration files for notejam app to be deployed on Kubernetes Cluster

The ingress service listens on notejam.k8s.example.com domain. Gets registered with main nginx-ingress controller where in the traffic gets routed to different apps

Built the Kubernetes cluster from scratch for this demo on Our Openstack tenant (could have done it easily on Azure or any other Public cloud but wanted to install from scratch with automation)

Thanks to Kubespray for helping me to deploy Kubernetes from scratch with automation (https://github.com/kubernetes-sigs/kubespray)

Found few pain points while installing Kubernetes cluster mainly with duplicate images. Hence, pushed the fix the issue. PR is here:: https://github.com/kubernetes-sigs/kubespray/pull/6941

Integrated above Kubernetes cluster with internal LDAP and proper RBAC access have been granted for users managing namespaces. 

I know the last four points aren't asked for. But, for me that was a great learning as I always had trouble understanding the Kubernetes under the hoods, Oauth2 integration with LDAP and so on., 

## What is not done?

Database isn't separated from the code. It still uses embedded database.

Separation of the environments. I'll try to finish for demo when I push CD changes. The plan is to have namespaces per environment and apply changes incrementally from lower environments to prod environment eventually

No metrics and logs support. 

Auto scaling of pods. 

License
-------
None

Authors Information
------------------
Harshavardhan Musanalli
