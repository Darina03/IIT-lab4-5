const express = require('express');
const app = express();
const path = require('path');

app.use(express.static(path.join(__dirname, '../frontend')));

app.post('/signup', (req, res) => {
    res.send('Signup successful!');
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => console.log(`Server is running on port ${PORT}`));
