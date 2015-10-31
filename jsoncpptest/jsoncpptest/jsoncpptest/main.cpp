//
//  main.cpp
//  jsoncpptest
//
//  Created by 黄奕龙 on 15/10/31.
//  Copyright © 2015年 Aaron Hwang. All rights reserved.
//

#include <iostream>
#include <string>
#include "json/json.h"



int main(void)

{
    
    Json::Value root;
    
    Json::FastWriter fast_writer;
    
    root["REGION_ID"] = "600901";
    
    root["DATA_TOTAL_NUM"] = "456278";
    
    std::cout << fast_writer.write(root) << std::endl;
    
    Json::Reader reader;
    Json::Value json_object;
    const char* json_document = "{\"age\" : 26,\"name\" : \"黄奕龙\"}";
    if (!reader.parse(json_document, json_object))
    return 0;
    std::cout << json_object["name"] << std::endl;
    std::cout << json_object["age"] << std::endl;
    
    return 0;
}