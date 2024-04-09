# @ Author: Bertan Berker
# @ Language: Python - Flask framework
# This is the backend for a decentralized tutoring full-stack web application

# Import necessary modules
import requests
from flask import request
from flask import Flask, jsonify
from flask_cors import CORS
import base64

# Create a Flask app
app = Flask(__name__)
CORS(app)


# Create and Connect to an SQL Database


# This function handles the login of a user and checks the database to make sure
# :parameters: JSON data containing 'username', 'password'
# :return: JSON response containing success or failure message
@app.route('/api/login', methods=['POST'])
def login():
    
    data = request.json

    if not data or 'username' not in data or 'password' not in data:
        return jsonify({'error': 'Invalid request data'}), 400

    username = data['username']
    password = data['password']

    
    return jsonify({'message': "User doesn't exist or incorrrect credentials"}), 400


# This function handles the registration of a user and adds them to the database
# :parameters: JSON data containing 'username', 'password'
# :return: JSON response containing success or failure message
@app.route('/api/register', methods=['POST'])
def register():
    
    # Extract username and password from the request body
    data = request.json

    # Check if 'data' is present and has the required fields
    if not data or 'username' not in data or 'password' not in data:
        return jsonify({'error': 'Invalid request data'}), 400

    username = data['username']
    password = data['password']

    # Insert the new user into the 'users' collection

    return jsonify({'message': 'User registered successfully'})    


# This function calls the Spotify API to search for an album based on keywords
# :parameters: JSON data containing 'query'
# :return: JSON response containing album's based on the keywords
@app.route('/api/search', methods = ['GET'])
def search_album():
    
    data = request.args

    if not data or 'query' not in data:
        return jsonify({'error': 'Invalid request data'}), 404
    
    access_token = connect_spotifyAPI()

    if not access_token:
        return jsonify({'error': 'Failed to obtain access token from Spotify API'})
    
    query = data['query']

    spotify_search_url = 'https://api.spotify.com/v1/search'
    headers = {
        'Authorization': f'Bearer {access_token}',
    }
    params = {
        'q': query,
        'type': 'album',
        'limit': 50
    }
    
    try:
        response = requests.get(spotify_search_url, headers=headers, params=params)
        response.raise_for_status()
        data = response.json()
        albums = data.get('albums', {}).get('items', [])
        
        # Extract relevant information (name and id) from each album
        results = [{'name': album['name'], 'id': album['id']} for album in albums]
        
        return jsonify(results=results)
    
    except requests.RequestException as e:
        return jsonify(error = str(e)), 500

