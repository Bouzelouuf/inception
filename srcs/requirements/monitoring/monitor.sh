#!/bin/bash

echo "=== INCEPTION MONITORING ==="
echo "Démarrage du monitoring..."

while true; do
    echo "$(date): Vérification des services..."
    
    # Test NGINX
    if curl -s -k https://nginx:443 >/dev/null 2>&1; then
        echo "✅ NGINX: OK"
    else
        echo "❌ NGINX: PROBLEME"
    fi
    
    # Test WordPress via le port FastCGI
    if nc -z wordpress 9000 >/dev/null 2>&1; then
        echo "✅ WordPress: OK" 
    else
        echo "❌ WordPress: PROBLEME"
    fi
    
    # Test MariaDB
    if nc -z mariadb 3306 >/dev/null 2>&1; then
        echo "✅ MariaDB: OK"
    else
        echo "❌ MariaDB: PROBLEME"
    fi
    
    # Test Redis
    if nc -z redis 6379 >/dev/null 2>&1; then
        echo "✅ Redis: OK"
    else
        echo "❌ Redis: PROBLEME"
    fi
    
    echo "--- Pause 30 secondes ---"
    sleep 30
done