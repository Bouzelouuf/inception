#!/bin/bash

echo "=== INCEPTION MONITORING ==="
echo "Démarrage du monitoring (5 minutes max)..."

# timeout limite l'exécution à 300 secondes (5 minutes)
timeout 300 bash -c '
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
'

echo "Monitoring terminé"
exit 0