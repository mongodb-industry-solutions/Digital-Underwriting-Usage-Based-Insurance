## Run the Data Loader Microservice 
```
cd DataMicroservice
```

````
uvicorn server:app --reload
````

### Docker

Build image:
```
docker build -f Dockerfile.back -t usage-based-back .
```

Build container:
```
docker run -d -p 8001:8000 --name usage-based-back usage-based-back
```

## Run the Frontend 
```
npm i 
```

```
npm run dev
```

### Docker

Build image:
```
docker build -f Dockerfile.front -t usage-based-front .
```

Build container:
```
docker run -d -p 3001:3001 --name usage-based-front usage-based-front
```
