from datetime import time

import pandas as pd
import requests
from bs4 import BeautifulSoup
import urllib.parse
import json

schoolnames = []
i=0
url = "https://www.dxsbb.com/news/1683.html"
response = requests.get(url)
response.encoding='utf-8'
html_content = response.text
soup = BeautifulSoup(html_content, 'html5lib')
tables = soup.find_all('table', attrs={'class': 'hasback'})
for table in tables:
    trs = table.find_all('tr')
    for tr in trs:
        tds = tr.find_all('td')
        i+=1
        if len(tds) > 1:
            schoolname = tds[1].text
            if i>1:
                schoolnames.append(schoolname)
df = pd.DataFrame({'School Name': schoolnames})
df.to_csv('school_names.csv', index=True)

for schoolname in schoolnames:
    encoded_name = urllib.parse.quote(schoolname)
    schoolurl="https://map.baidu.com/?newmap=1&reqflag=pcmap&biz=1&from=webmap&da_par=direct&pcevaname=pc4.1&qt=s&da_src=searchBox.button&wd="+encoded_name+"&c=257&src=0&wd2=&pn=0&sug=0&l=14&b=(12611715.153086824,2623097.7001289134;12618327.357064726,2632067.4198710867)&from=webmap&biz_forward={%22scaler%22:2,%22styles%22:%22pl%22}&sug_forward=&auth=8P%3DQHzdO9YXy1V7wayvVXNy6QCx0CKYcuxNBLLxzLBztBB4BJ466GBwGvgz%402VJtyDx8zKfIORgY4BI4%3DPAiUI0DiRZHGOcW1V4wzPD44zBDJWvEG8e1aDvkGcuVtvvhguVtvyheuVtvCMGuVtvCQMuVtvIPcuxtw8wkv7uvZgMuVtv%40vcuVtvc3CuVtvcPPuVtveGvuzVTt1mqQD%3DCvh3CuVtvhgMuzVVtvrMhuBEEtJggagyBxf0wd0vyOCMMyACI7&seckey=E3V0YjYZ814r7x4OMnhki06EZzJ5Si2w64BMokti4S4%3D%2Ct5BQOKvjeG24bpJ7QFh-HSloiphzt20f3Tyqde9WfAlIK8o5hapATnOTJ7p_Pgu5uqT5GIjxj1BH6fIw7_exykAcjg8vAk3j38pCosGEvRNGadZKS4QUwWjKjYlgeKizYkl9OmfaXCj5lfYJeI0WUf9rfbKiTPd9se1NiTuzIf0fn4tf51RIzT2HfUmkyWWucxNc_48ve1WZG8qS9JQaNg&device_ratio=2&tn=B_NORMAL_MAP&nn=0&u_loc=12643895,2652787&ie=utf-8&t=1736612636743&newfrom=zhuzhan_webmap"
    response2=requests.get(schoolurl)
    print(response2)
