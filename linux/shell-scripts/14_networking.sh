14. Networking in Shell

File: `14_networking.sh`

#!/bin/bash
# =============================================================================
# NETWORKING IN SHELL - Complete Guide
# =============================================================================

set -euo pipefail

# =============================================================================
# CURL - ADVANCED HTTP CLIENT
# =============================================================================

echo "=== CURL - ADVANCED HTTP CLIENT ==="

# Basic curl usage
demo_curl_basics() {
    echo "Basic curl operations:"
    
    echo -e "\n1. Simple GET request:"
    echo "   curl -s http://httpbin.org/get"
    if curl -s --connect-timeout 5 http://httpbin.org/get >/dev/null 2>&1; then
        echo "   ✓ Connection successful"
    else
        echo "   ✗ Connection failed (using local examples)"
    fi
    
    echo -e "\n2. Download file with progress:"
    echo "   curl -O -# http://example.com/file.txt"
    # Simulate download
    echo "   (Simulated) ######## 100.0%"
    
    echo -e "\n3. Follow redirects:"
    echo "   curl -L http://bit.ly/shortened-url"
    
    echo -e "\n4. Custom headers:"
    echo "   curl -H 'User-Agent: MyApp/1.0' -H 'Accept: application/json' http://api.example.com"
    
    echo -e "\n5. POST data:"
    echo "   curl -X POST -d 'name=John&age=30' http://httpbin.org/post"
    
    echo -e "\n6. JSON POST:"
    echo "   curl -X POST -H 'Content-Type: application/json' -d '{\"name\":\"John\"}' http://api.example.com"
    
    echo -e "\n7. Authentication:"
    echo "   curl -u username:password http://secure.example.com"
    echo "   curl -H 'Authorization: Bearer token123' http://api.example.com"
}

# Advanced curl features
demo_curl_advanced() {
    echo -e "\nAdvanced curl features:"
    
    # Create test data
    cat > test_data.json << 'EOF'
{
    "name": "John Doe",
    "email": "john@example.com",
    "age": 30
}
EOF
    
    echo -e "\n1. Upload file:"
    echo "   curl -X POST -F 'file=@test_data.json' http://httpbin.org/post"
    
    echo -e "\n2. Save cookies:"
    echo "   curl -c cookies.txt -b cookies.txt http://example.com"
    
    echo -e "\n3. Timing information:"
    echo "   curl -w '@curl-format.txt' http://example.com"
    
    # Create curl format file
    cat > curl-format.txt << 'EOF'
     namelookup:  %{time_namelookup}s
        connect:  %{time_connect}s
     appconnect:  %{time_appconnect}s
    pretransfer:  %{time_pretransfer}s
       redirect:  %{time_redirect}s
  starttransfer:  %{time_starttransfer}s
                 ----------
          total:  %{time_total}s
EOF
    
    echo -e "\n4. Multiple URLs:"
    echo "   curl http://site1.com http://site2.com http://site3.com"
    
    echo -e "\n5. Rate limiting:"
    echo "   curl --limit-rate 100K http://example.com/largefile"
    
    echo -e "\n6. Retry on failure:"
    echo "   curl --retry 3 --retry-delay 2 http://unreliable.com"
    
    # Cleanup
    rm -f test_data.json curl-format.txt cookies.txt
}

# Curl for API testing
demo_curl_api_testing() {
    echo -e "\nCurl for API testing:"
    
    # API testing function
    test_api_endpoint() {
        local method="$1"
        local url="$2"
        local data="$3"
        local expected_status="$4"
        
        echo "Testing: $method $url"
        
        local response_file=$(mktemp)
        local status_code
        
        if [[ -n "$data" ]]; then
            status_code=$(curl -s -X "$method" \
                -H "Content-Type: application/json" \
                -d "$data" \
                -w "%{http_code}" \
                -o "$response_file" \
                "$url" 2>/dev/null || echo "000")
        else
            status_code=$(curl -s -X "$method" \
                -w "%{http_code}" \
                -o "$response_file" \
                "$url" 2>/dev/null || echo "000")
        fi
        
        echo "  Status: $status_code (expected: $expected_status)"
        
        if [[ "$status_code" == "$expected_status" ]]; then
            echo "  ✓ Test passed"
        else
            echo "  ✗ Test failed"
        fi
        
        # Show response body (first few lines)
        if [[ -s "$response_file" ]]; then
            echo "  Response:"
            head -3 "$response_file" | sed 's/^/    /'
        fi
        
        rm -f "$response_file"
    }
    
    echo -e "\n1. API endpoint testing (simulated):"
    # Note: These would be real API calls in practice
    echo "   GET /users - List users"
    echo "   POST /users - Create user"
    echo "   PUT /users/123 - Update user"
    echo "   DELETE /users/123 - Delete user"
}

demo_curl_basics
demo_curl_advanced
demo_curl_api_testing

# =============================================================================
# WGET - FILE DOWNLOADER
# =============================================================================

echo -e "\n=== WGET - FILE DOWNLOADER ==="

demo_wget_basics() {
    echo "Basic wget operations:"
    
    echo -e "\n1. Simple download:"
    echo "   wget http://example.com/file.txt"
    
    echo -e "\n2. Download to specific directory:"
    echo "   wget -P /tmp http://example.com/file.txt"
    
    echo -e "\n3. Resume interrupted download:"
    echo "   wget -c http://example.com/largefile.zip"
    
    echo -e "\n4. Background download:"
    echo "   wget -b http://example.com/file.txt"
    
    echo -e "\n5. Limit download speed:"
    echo "   wget --limit-rate=100k http://example.com/file.txt"
    
    echo -e "\n6. Download with retries:"
    echo "   wget --tries=3 --waitretry=2 http://unreliable.com/file.txt"
    
    echo -e "\n7. Mirror website:"
    echo "   wget -m -p -E -k -K -np http://example.com"
    
    echo -e "\n8. Download multiple files from list:"
    cat > url_list.txt << 'EOF'
http://example.com/file1.txt
http://example.com/file2.txt
http://example.com/file3.txt
EOF
    
    echo "   wget -i url_list.txt"
    echo "   Created url_list.txt with sample URLs"
    
    rm -f url_list.txt
}

# Advanced wget features
demo_wget_advanced() {
    echo -e "\nAdvanced wget features:"
    
    echo -e "\n1. User agent and headers:"
    echo "   wget --user-agent='Mozilla/5.0' --header='Accept: text/html' http://example.com"
    
    echo -e "\n2. Authentication:"
    echo "   wget --user=username --password=password http://secure.example.com"
    echo "   wget --header='Authorization: Bearer token' http://api.example.com"
