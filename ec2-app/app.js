const express = require('express');
const app = express();
const port = process.env.PORT || 3000;

app.get('/ec2', (req, res) => {
  res.status(200);
  res.send({
    message: 'Hello from EC2!'
  });
});

app.listen(port, () => console.log(`Listening on ${port}...`));
