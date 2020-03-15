SHELL := /bin/bash

.PHONY: help

help:
	@echo "============================================"
	@echo "# 	   	  HELP make <target>	          #"
	@echo "============================================"
	@echo "#  init       	 terraform init   	   	   "
	@echo "#  plan       	 terraform plan  	   	   "
	@echo "#  deploy       	 Create cluster   	   	   "
	@echo "#  destroy      	 Destroy cluster  	   	   "
	@echo "============================================"

init:
	@echo "====================================================================================================================================="
	@echo " 			                           INITIATING TERRAFROM........					                            					"
	@echo "====================================================================================================================================="
	bash -c "terraform init"
	@echo "====================================================================================================================================="
	@echo " 			                           TERRAFORM INITIATED         							 	 										"
	@echo "====================================================================================================================================="
plan:
	@echo "====================================================================================================================================="
	@echo " 			                           PLANNING TERRAFROM........				                             						"
	@echo "====================================================================================================================================="
	bash -c "terraform plan"
	@echo "====================================================================================================================================="
	@echo "				                           TERRAFORM PLANNED               							 	 								"
	@echo "====================================================================================================================================="
deploy:
	@echo "====================================================================================================================================="
	@echo "				                           CLUSTER IS INITIATING........			                             						"
	@echo "====================================================================================================================================="
	bash -c "terraform init && terraform apply --auto-approve=true"
	bash -c "aws eks update-kubeconfig --name dev-eks --region us-west-2"
	@echo "====================================================================================================================================="
	@echo "				                           CLUSTER IS CREATED		                             										"
	@echo "====================================================================================================================================="
destroy:
	@echo "====================================================================================================================================="
	@echo " 			                           CLUSTEER IS DESTROYING........                                           					"
	@echo "====================================================================================================================================="
	bash -c "terraform destroy --auto-approve=true"
	@echo "====================================================================================================================================="
	@echo "				                           CLUSTER IS DESTROYED                                        									"
	@echo "====================================================================================================================================="