1. Usecase 1: Json -> ETDict
```string json = "{\"key1\": 1, \"key2\": 2.5}";
ETDict * dict = new ETDict();
dict.Deserialize(json);```
//Get value
int val1 = dict["key1"].ToInt();
int val2 = dict["key2"].ToDouble();```

2. Usecase 2: ETDict to Json
```ETDict * dict = new ETDict();
dict["key1"] = 1;
dict["key2"] = 2.5;
string json = dict.Serialize();```
