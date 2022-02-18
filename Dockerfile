FROM mongo:4.2.3

EXPOSE 3099 27017

ADD mongo_scripts/run.sh /run.sh
ADD mongo_scripts/set_pwd.sh /set_pwd.sh

RUN chmod +x /run.sh
RUN chmod +x /set_pwd.sh

CMD ["/run.sh"]
