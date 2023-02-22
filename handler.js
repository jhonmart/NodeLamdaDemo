"use strict";

const requestNode = (event) =>
  new Promise((resolve, reject) => {
    const http = require("http");
    let responseBody = "";
    const req = http.request(event, (res) => {
      res.setEncoding("utf8");
      console.log(`statusCode: ${res.statusCode}`);
      res.on("data", (chunk) => {
        responseBody += chunk;
      });

      res.on("end", () => {
        resolve({
          statusCode: 200,
          body: responseBody,
        });
      });

      res.on("error", (error) => {
        reject({
          statusCode: 500,
          body: JSON.stringify(
            {
              message: "Falha interna",
              error,
            },
            null,
            2
          ),
        });
      });
    });
    event.body && req.write(JSON.stringify(event.body));
    req.end();
  });

module.exports.request = async (event, context) => {
  return await requestNode(event);
};
