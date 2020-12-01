FROM hub.docker.com
EXPOSE 5000
ADD files /root
ADD rhel7.repo /etc/yum.repos.d/rhel7.repo
ADD runserver.py /root/runserver.py
ADD requirements.txt /root/requirements.txt
ADD db.py /root/db.py
RUN microdnf install --nodocs -y python2 python2-devel PyYAML python2-jinja2 python2-paramiko python2-pip python2-cryptography python2-httplib2 python2-jmespath python-passlib python2-requests
RUN cd /root && pip install -r requirements.txt && python /root/db.py
ENTRYPOINT ["python", "/root/runserver.py"]
