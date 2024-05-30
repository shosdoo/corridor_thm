#!/bin/bash
for n in {0..100}
do
	echo -n "$n" | md5sum | awk '{print $1}' >> hashmd5.txt
done

echo "1679091c5a880faf6fb5e6087eb1b2dc
45c48cce2e2d7fbdea1afc51c7c6ad26
6512bd43d9caa6e02c990b0a82652dca
8f14e45fceea167a5a36dedd4bea2543
a87ff679a2f3e71d9181a67b7542122c
c20ad4d76fe97759aa27a0c99bff6710
c4ca4238a0b923820dcc509a6f75849b
c51ce410c124a10e0db5e4b97fc2af39
c81e728d9d4c2f636f067f89cc14862c
c9f0f895fb98ab9159f51fd0297e236d
d3d9446802a44259755d38e6d163e820
e4da3b7fbbce2345d7772b0674a318d5
eccbc87e4b5ce2fe28308fd9f2a7baf3" > dif.txt

nohup ffuf -c -u http://10.10.118.38/FUZZ -w hashmd5.txt -o res.json >/dev/null 2>&1
grep -oP 'http:\/\/10\.10\.118\.38\/[a-fA-F0-9]{32}' res.json | tr '/' ' ' | awk '{print $NF}' > retu.txt
sort retu.txt >> caca.txt
diff caca.txt dif.txt | awk '{print "Cadena diferente: "$2}'| tail -1
rm retu.txt && rm res.json && rm hashmd5.txt && rm caca.txt && rm dif.txt

