#!/usr/bin/env python3
"""
Flask application exposing REST API endpoints
"""
from flask import Flask, jsonify, request
from datetime import datetime
import os
import logging

# Configure logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

app = Flask(__name__)

# Health check endpoint
@app.route('/health', methods=['GET'])
def health():
    """Health check endpoint for container orchestration"""
    return jsonify({
        'status': 'healthy',
        'timestamp': datetime.utcnow().isoformat()
    }), 200

# Readiness probe endpoint
@app.route('/ready', methods=['GET'])
def readiness():
    """Readiness probe endpoint"""
    return jsonify({
        'ready': True,
        'app_version': os.getenv('APP_VERSION', '1.0.0')
    }), 200

# Main API endpoint
@app.route('/api/hello', methods=['GET', 'POST'])
def hello():
    """Main API endpoint that returns a greeting"""
    name = request.args.get('name', 'World')
    
    if request.method == 'POST':
        data = request.get_json() or {}
        name = data.get('name', name)
    
    return jsonify({
        'message': f'Hello, {name}!',
        'timestamp': datetime.utcnow().isoformat(),
        'method': request.method
    }), 200

# Status endpoint
@app.route('/api/status', methods=['GET'])
def status():
    """Return application status"""
    return jsonify({
        'app_name': 'Python Container App',
        'version': os.getenv('APP_VERSION', '1.0.0'),
        'environment': os.getenv('ENVIRONMENT', 'development'),
        'timestamp': datetime.utcnow().isoformat()
    }), 200

# Error handlers
@app.errorhandler(404)
def not_found(error):
    """Handle 404 errors"""
    return jsonify({
        'error': 'Not Found',
        'message': 'The requested endpoint does not exist'
    }), 404

@app.errorhandler(500)
def internal_error(error):
    """Handle 500 errors"""
    logger.error(f'Internal error: {error}')
    return jsonify({
        'error': 'Internal Server Error',
        'message': 'An unexpected error occurred'
    }), 500

if __name__ == '__main__':
    port = int(os.getenv('PORT', 5000))
    debug = os.getenv('DEBUG', 'False').lower() == 'true'
    app.run(host='0.0.0.0', port=port, debug=debug)
