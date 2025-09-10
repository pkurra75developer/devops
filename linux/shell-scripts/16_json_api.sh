Based on the provided contexts about jq and JSON parsing in shell scripts, here's a complete shell script for working with JSON and APIs:


#!/bin/bash
# File: 16_json_api.sh
# Working with JSON and APIs in Shell Scripting

# Colors for output formatting
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}=== Working with JSON and APIs ===${NC}\n"

# Check if jq is installed
check_jq() {
    if ! command -v jq &> /dev/null; then
        echo -e "${RED}Error: jq is not installed. Please install it first.${NC}"
        echo "Ubuntu/Debian: sudo apt-get install jq"
        echo "CentOS/RHEL: sudo yum install jq"
        echo "macOS: brew install jq"
        exit 1
    fi
}

# Function to demonstrate basic jq JSON parsing
demo_basic_json_parsing() {
    echo -e "${YELLOW}1. Basic JSON Parsing with jq${NC}"
    
    # Sample JSON data
    json_data='{
        "name": "John Doe",
        "age": 30,
        "city": "New York",
        "skills": ["bash", "python", "docker"],
        "address": {
            "street": "123 Main St",
            "zipcode": "10001"
        }
    }'
    
    echo "Sample JSON:"
    echo "$json_data" | jq '.'
    
    echo -e "\n${GREEN}Extracting specific fields:${NC}"
    echo "Name: $(echo "$json_data" | jq -r '.name')"
    echo "Age: $(echo "$json_data" | jq -r '.age')"
    echo "First skill: $(echo "$json_data" | jq -r '.skills[0]')"
    echo "Street address: $(echo "$json_data" | jq -r '.address.street')"
    echo ""
}

# Function to call REST APIs and handle responses
demo_api_calls() {
    echo -e "${YELLOW}2. Calling REST APIs and Handling Responses${NC}"
    
    # Example 1: JSONPlaceholder API (fake REST API for testing)
    echo -e "${GREEN}Fetching user data from JSONPlaceholder API:${NC}"
    
    api_response=$(curl -s "https://jsonplaceholder.typicode.com/users/1")
    
    if [ $? -eq 0 ] && [ -n "$api_response" ]; then
        echo "Raw API Response:"
        echo "$api_response" | jq '.'
        
        echo -e "\n${GREEN}Parsed data:${NC}"
        name=$(echo "$api_response" | jq -r '.name')
        email=$(echo "$api_response" | jq -r '.email')
        company=$(echo "$api_response" | jq -r '.company.name')
        
        echo "User: $name"
        echo "Email: $email"
        echo "Company: $company"
    else
        echo -e "${RED}Failed to fetch data from API${NC}"
    fi
    echo ""
}

# Function to demonstrate advanced jq filtering and manipulation
demo_advanced_jq() {
    echo -e "${YELLOW}3. Advanced jq Operations${NC}"
    
    # Sample array of JSON objects
    users_json='[
        {"id": 1, "name": "Alice", "age": 25, "department": "Engineering"},
        {"id": 2, "name": "Bob", "age": 30, "department": "Marketing"},
        {"id": 3, "name": "Charlie", "age": 35, "department": "Engineering"},
        {"id": 4, "name": "Diana", "age": 28, "department": "Sales"}
    ]'
    
    echo -e "${GREEN}Original data:${NC}"
    echo "$users_json" | jq '.'
    
    echo -e "\n${GREEN}Filter users in Engineering department:${NC}"
    echo "$users_json" | jq '.[] | select(.department == "Engineering")'
    
    echo -e "\n${GREEN}Get names of users older than 27:${NC}"
    echo "$users_json" | jq '.[] | select(.age > 27) | .name'
    
    echo -e "\n${GREEN}Create summary with just names and ages:${NC}"
    echo "$users_json" | jq 'map({name: .name, age: .age})'
    
    echo -e "\n${GREEN}Count users by department:${NC}"
    echo "$users_json" | jq 'group_by(.department) | map({department: .[0].department, count: length})'
    echo ""
}

# Function to handle API errors and edge cases
demo_error_handling() {
    echo -e "${YELLOW}4. Error Handling and Edge Cases${NC}"
    
    # Function to make API call with error handling
    make_api_call() {
        local url=$1
        local response
        local http_code
        
        # Make API call and capture both response and HTTP status
        response=$(curl -s -w "%{http_code}" "$url")
        http_code="${response: -3}"
        response="${response%???}"
        
        case $http_code in
            200)
                echo -e "${GREEN}Success (HTTP $http_code)${NC}"
                echo "$response" | jq '.' 2>/dev/null || echo "Invalid JSON response"
                ;;
            404)
                echo -e "${RED}Error: Resource not found (HTTP $http_code)${NC}"
                ;;
            500)
                echo -e "${RED}Error: Server error (HTTP $http_code)${NC}"
                ;;
            *)
                echo -e "${RED}Error: HTTP $http_code${NC}"
                echo "Response: $response"
                ;;
        esac
    }
    
    echo -e "${GREEN}Testing valid API endpoint:${NC}"
    make_api_call "https://jsonplaceholder.typicode.com/posts/1"
    
    echo -e "\n${GREEN}Testing invalid API endpoint:${NC}"
    make_api_call "https://jsonplaceholder.typicode.com/posts/999999"
    echo ""
}

# Function to demonstrate working with local JSON files
demo_json_files() {
    echo -e "${YELLOW}5. Working with JSON Files${NC}"
    
    # Create a sample JSON file
    cat > sample_config.json << EOF
{
    "database": {
        "host": "localhost",
        "port": 5432,
        "name": "myapp",
        "credentials": {
            "username": "admin",
            "password": "secret123"
        }
    },
    "api": {
        "endpoints": [
            {"name": "users", "url": "/api/v1/users"},
            {"name": "posts", "url": "/api/v1/posts"}
        ],
        "rate_limit": 1000
    }
}
EOF
    
    echo -e "${GREEN}Reading configuration from JSON file:${NC}"
    
    # Read and parse JSON file
    if [ -f "sample_config.json" ]; then
        db_host=$(jq -r '.database.host' sample_config.json)
        db_port=$(jq -r '.database.port' sample_config.json)
        api_rate_limit=$(jq -r '.api.rate_limit' sample_config.json)
        
        echo "Database Host: $db_host"
        echo "Database Port: $db_port"
        echo "API Rate Limit: $api_rate_limit"
        
        echo -e "\n${GREEN}API Endpoints:${NC}"
        jq -r '.api.endpoints[] | "\(.name): \(.url)"' sample_config.json
        
        # Modify JSON file
        echo -e "\n${GREEN}Updating rate limit in JSON file:${NC}"
        jq '.api.rate_limit = 2000' sample_config.json > temp.json
        mv temp.json sample_config.json
        echo "Updated rate limit to: $(jq -r '.api.rate_limit' sample_config.json)"
        
        # Clean up
        rm -f sample_config.json
    fi
    echo ""
}

# Function to demonstrate POST requests with JSON data
demo_post_requests() {
    echo -e "$${YELLOW}6. Making POST Requests with JSON Data$$ {NC}"
    
    # Sample JSON payload
    post_data='{
        "title": "My New Post",
        "body": "This is the content of my post",
        "userId": 1
    }'
    
    echo -e "${GREEN}Sending POST request with JSON data:${NC}"
    echo "Payload: $post_data"
    
    response=$(curl -s -X POST \
        -H "Content-Type: application/json" \
        -d "$post_data" \
        "https://jsonplaceholder.typicode.com/posts")
    
    if [ $? -eq 0 ]; then
        echo -e "\n${GREEN}Response:${NC}"
        echo "$response" | jq '.'
        
        # Extract specific fields from response
        post_id=$(echo "$response" | jq -r '.id')
        echo -e "\n${GREEN}Created post with ID: $$post_id$$ {NC}"
    else
        echo -e "$${RED}Failed to create post$$ {NC}"
    fi
    echo ""
}

# Function to demonstrate authentication with APIs
demo_api_auth() {
    echo -e "$${YELLOW}7. API Authentication Examples$$ {NC}"
    
    # Example with API key in header
    echo -e "${GREEN}Example: API Key Authentication${NC}"
    echo "curl -H 'Authorization: Bearer YOUR_API_KEY' https://api.example.com/data"
    
    # Example with basic auth
    echo -e "\n${GREEN}Example: Basic Authentication${NC}"
    echo "curl -u username:password https://api.example.com/data"
    
    # Example function for authenticated API call
    make_authenticated_call() {
        local api_key=$1
        local endpoint=$2
        
        if [ -z "$api_key" ]; then
            echo -e "${RED}Error: API key required${NC}"
            return 1
        fi
        
        curl -s -H "Authorization: Bearer $api_key" "$endpoint"
    }
    
    echo -e "\n${GREEN}Function created: make_authenticated_call${NC}"
    echo ""
}

# Function to demonstrate batch processing of JSON data
demo_batch_processing() {
    echo -e "$${YELLOW}8. Batch Processing JSON Data$$ {NC}"
    
    # Simulate fetching multiple posts
    echo -e "${GREEN}Fetching multiple posts and processing:${NC}"
    
    posts=$(curl -s "https://jsonplaceholder.typicode.com/posts?_limit=5")
    
    if [ $? -eq 0 ]; then
        echo "Total posts fetched: $(echo "$posts" | jq 'length')"
        
        echo -e "\n${GREEN}Post titles:${NC}"
        echo "$posts" | jq -r '.[] | "- $$.title)"'
        
        echo -e "\n${GREEN}Posts by user 1:${NC}"
        echo "$posts" | jq '.[] | select(.userId == 1) | .title'
        
        echo -e "\n${GREEN}Creating summary report:${NC}"
        echo "$posts" | jq 'group_by(.userId) | map({userId: .[0].userId, postCount: length})'
    fi
    echo ""
}

# Function to create reusable API wrapper functions
create_api_wrapper() {
    echo -e "\({YELLOW}9. Reusable API Wrapper Functions$$ {NC}"
    
    # Generic API call function
    api_call() {
        local method=${1:-GET}
        local url=$2
        local data=$3
        local headers=$4
        
        local curl_opts="-s"
        
        case $method in
            GET)
                curl_opts="$curl_opts -X GET"
                ;;
            POST)
                curl_opts="$curl_opts -X POST -H 'Content-Type: application/json'"
                if [ -n "$data" ]; then
                    curl_opts="$$curl_opts -d '$$ data'"
                fi
                ;;
            PUT)
                curl_opts="$curl_opts -X PUT -H 'Content-Type: application/json'"
                if [ -n "$data" ]; then
                    curl_opts="$$curl_opts -d '$$ data'"
                fi
                ;;
            DELETE)
                curl_opts="$curl_opts -X DELETE"
                ;;
        esac
        
        if [ -n "$headers" ]; then
            curl_opts="$$curl_opts$$ headers"
        fi
        
        eval "curl $$curl_opts '$$ url'"
    }
    
    echo -e "$${GREEN}Created generic api_call function$$ {NC}"
    echo "Usage: api_call METHOD URL [DATA] [HEADERS]"
    
    # Example usage
    echo -e "\n${GREEN}Example usage:${NC}"
    result=$(api_call GET "https://jsonplaceholder.typicode.com/posts/1")
    echo "Fetched post: $(echo "$result" | jq -r '.title')"
    echo ""
}

# Main execution
main() {
    check_jq
    
    demo_basic_json_parsing
    demo_api_calls
    demo_advanced_jq
    demo_error_handling
    demo_json_files
    demo_post_requests
    demo_api_auth
    demo_batch_processing
    create_api_wrapper
    
    echo -e "$${BLUE}=== JSON and API Operations Complete ===$$ {NC}"
    echo -e "${GREEN}Key takeaways:${NC}"
    echo "1. Always check if jq is installed before using it"
    echo "2. Handle API errors gracefully with proper HTTP status checking"
    echo "3. Use jq for robust JSON parsing and manipulation"
    echo "4. Implement proper authentication for secure APIs"
    echo "5. Create reusable functions for common API operations"
}

# Run the main function
main "$@"