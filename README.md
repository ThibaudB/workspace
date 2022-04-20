# workspace

## How to install

```sh
curl -u user:token  \
  -H 'Accept: application/vnd.github.v3.raw' \
  -O -L https://api.github.com/repos/thibaudb/workspace/contents/download.sh \
  && sudo chmod +x download.sh && ./download.sh
```

To test:
```
sh -u user:token -c "$(curl -fsSL https://raw.github.com/thibaudb/workspace/master/download.sh)"
```
