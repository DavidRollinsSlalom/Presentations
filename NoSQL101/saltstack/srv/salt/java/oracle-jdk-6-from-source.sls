oracle-jdk-6:
  cmd.run:
    - name: |
          mkdir -p /usr/java
          cd /usr/java
          wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/6u45-b06/jdk-6u45-linux-x64.bin"
          chmod +x jdk-6u45-linux-x64.bin
          ./jdk-6u45-linux-x64.bin
          rm jdk-6u45-linux-x64.bin
