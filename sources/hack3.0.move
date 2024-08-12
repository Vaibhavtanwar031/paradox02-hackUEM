<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ambulance Tracker</title>
    <link rel="stylesheet" href="https://unpkg.com/leaflet/dist/leaflet.css" />
    <style>
        #map {
            height: 100vh;
        }
    </style>
</head>
<body>
    <h1>Ambulance Tracker</h1>
    <div id="map"></div>
    <script src="https://unpkg.com/leaflet/dist/leaflet.js"></script>
    <script>
        // Initialize the map
        const map = L.map('map').setView([0, 0], 13);

        // Add a tile layer to the map
        L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
            attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
        }).addTo(map);

        // Function to update ambulance position
        function updateAmbulancePosition(lat, lng) {
            L.marker([lat, lng]).addTo(map)
                .bindPopup('Ambulance Location')
                .openPopup();
            map.setView([lat, lng], 13);
        }

        // Simulate receiving new ambulance position from server
        function simulatePositionUpdate() {
            // Replace with actual server data
            const lat = Math.random() * 90 - 45;
            const lng = Math.random() * 180 - 90;
            updateAmbulancePosition(lat, lng);
        }

        // Poll for updates every 5 seconds (for demo purposes)
        setInterval(simulatePositionUpdate, 5000);
    </script>
</body>
</html>
const express = require('express');
const app = express();
const PORT = 3000;

app.use(express.json());

let ambulanceLocations = {};

// Endpoint to update ambulance location
app.post('/updateLocation', (req, res) => {
    const { ambulanceId, lat, lng } = req.body;
    if (ambulanceId && lat && lng) {
        ambulanceLocations[ambulanceId] = { lat, lng };
        res.json({ success: true, message: 'Location updated' });
    } else {
        res.status(400).json({ success: false, message: 'Invalid data' });
    }
});

// Endpoint to get all ambulance locations
app.get('/locations', (req, res) => {
    res.json(ambulanceLocations);
});

app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});
// This is a simplified representation. You would use a framework like React Native, Flutter, or similar.

function sendLocationUpdate(ambulanceId, lat, lng) {
    fetch('http://localhost:3000/updateLocation', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({ ambulanceId, lat, lng })
    })
    .then(response => response.json())
    .then(data => console.log('Location updated:', data))
    .catch(error => console.error('Error:', error));
}

// Example usage: Send location update every 10 seconds
setInterval(() => {
    const ambulanceId = 'ambulance1';
    const lat = getCurrentLatitude(); // Function to get current latitude
    const lng = getCurrentLongitude(); // Function to get current longitude
    sendLocationUpdate(ambulanceId, lat, lng);
}, 10000);
