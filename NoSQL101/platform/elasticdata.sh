status=$(curl -s -X DELETE localhost:9200/_template/*)
echo "Deleting old templates. Status = $status"

status=$(curl -s -X DELETE localhost:9200/*)
echo "Deleting old indices. Status = $status"

version=1.0

cd /ng-scp/worker/conf/elasticsearch

echo "Downloading from http://psl-devnexus01.lab.securustech.net/content/groups/ngscp-repos/net/securustech/esTemplates/$version/esTemplates-$version.zip"

curl -L "http://psl-devnexus01.lab.securustech.net/content/groups/ngscp-repos/net/securustech/esTemplates/$version/esTemplates-$version.zip" -o esTemplates.zip
printf A | unzip esTemplates.zip

bash upload-templates.sh
rm esTemplates.zip

if [ ! -f dev.json.gz ]
then
    echo "Downloading file from dev server..."
    wget -O dev.json.gz "http://psl-devngscpdb01.lab.securustech.net/data/dev.json.gz" --no-verbose
    echo "Download complete. "
fi
echo "Unzipping and importing file..."
gunzip -c dev.json.gz | elasticdump --input=$ --output=http://localhost:9200 --bulk --limit=5000
