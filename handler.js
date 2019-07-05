'use strict';

module.exports.handle = async (event) => {
  return {
    statusCode: 200,
    body: JSON.stringify({
      message: 'Hello from AWS Lambda!',
      input: event,
    }, null, 2),
  };
};
