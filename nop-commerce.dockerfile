FROM mcr.microsoft.com/dotnet/aspnet:6.0 as sweety
ADD https://github.com/nopSolutions/nopCommerce/releases/download/release-4.50.3/nopCommerce_4.50.3_NoSource_linux_x64.zip .
RUN apt update && \
    apt install unzip -y && \
    unzip ./nopCommerce_4.50.3_NoSource_linux_x64.zip
EXPOSE 80 
CMD ["dotnet", "Nop.Web.dll", "run", "--server.urls=http://0.0.0.0:*"]    

    








FROM mcr.microsoft.com/dotnet/aspnet:6.0 
RUN apt update && \
    apt install nginx unzip -y && \
    mkdir /var/www/nopCommerce && \
    cd /var/www/nopCommerce    
ADD https://github.com/nopSolutions/nopCommerce/releases/download/release-4.50.3/nopCommerce_4.50.3_NoSource_linux_x64.zip /var/www/nopCommerce
WORKDIR /var/www/nopCommerce 
RUN unzip ./nopCommerce_4.50.3_NoSource_linux_x64.zip && \
    mkdir bin logs && \
    cd .. && \
    chgrp -R www-data nopCommerce/* && \
    chmod -R 777 nopCommerce/* && \
    chown -R www-data nopCommerce/*
EXPOSE 80 
CMD ["dotnet", "Nop.Web.dll", "run", "--server.urls=http://0.0.0.0:*"]    

    