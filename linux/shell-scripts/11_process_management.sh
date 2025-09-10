#!/bin/bash
# =============================================================================
# PROCESS MANAGEMENT - Complete Guide
# =============================================================================

set -euo pipefail

# =============================================================================
# BACKGROUND AND FOREGROUND JOBS
# =============================================================================

echo "=== BACKGROUND AND FOREGROUND JOBS ==="

# Function to simulate a long-running task
long_task() {
    local task_name="$1"
    local duration="${2:-5}"
    
    echo "[$task_name] Starting task (PID: $$)"
    for i in $(seq 1 "$duration"); do
        echo "[$task_name] Working... step $i/$duration"
        sleep 1
    done
    echo "[$task_name] Task completed!"
}

# Demonstrate background jobs
echo "Starting background jobs:"

# Start jobs in background using &
long_task "Background-1" 3 &
job1_pid=$!
echo "Started Background-1 with PID: $job1_pid"

long_task "Background-2" 4 &
job2_pid=$!
echo "Started Background-2 with PID: $job2_pid"

# Show current jobs
echo -e "\nCurrent jobs:"
jobs

# Wait a moment then show jobs again
sleep 2
echo -e "\nJobs after 2 seconds:"
jobs

# Demonstrate job control commands
echo -e "\nJob control demonstration:"

# Start a job that we can control
{
    echo "Controllable job starting..."
    for i in {1..10}; do
        echo "Controllable job: step $i"
        sleep 1
    done
    echo "Controllable job finished"
} &
controllable_pid=$!

echo "Started controllable job with PID: $controllable_pid"
sleep 2

# Show job status
echo "Job status:"
jobs -l

# Note: In a script, fg/bg commands don't work the same as in interactive shell
# This is a limitation of non-interactive bash
echo "Note: fg/bg commands work in interactive shells, not in scripts"

# =============================================================================
# WAIT COMMAND
# =============================================================================

echo -e "\n=== WAIT COMMAND ==="

# Function to demonstrate wait
demo_wait() {
    echo "Demonstrating wait command:"
    
    # Start multiple background processes
    {
        echo "Process A starting"
        sleep 3
        echo "Process A finished"
        exit 10
    } &
    pid_a=$!
    
    {
        echo "Process B starting"
        sleep 2
        echo "Process B finished"
        exit 20
    } &
    pid_b=$!
    
    {
        echo "Process C starting"
        sleep 4
        echo "Process C finished"
        exit 30
    } &
    pid_c=$!
    
    echo "Started processes A($pid_a), B($pid_b), C($pid_c)"
    
    # Wait for specific process
    echo "Waiting for Process B to complete..."
    wait $pid_b
    echo "Process B completed with exit code: $?"
    
    # Wait for all remaining processes
    echo "Waiting for all remaining processes..."
    wait
    echo "All processes completed"
    
    # Demonstrate wait with exit codes
    echo -e "\nChecking exit codes of completed processes:"
    
    # Start processes with different exit codes
    (sleep 1; exit 0) &
    success_pid=$!
    
    (sleep 1; exit 1) &
    failure_pid=$!
    
    # Wait and check exit codes
    if wait $success_pid; then
        echo "Success process completed successfully"
    else
        echo "Success process failed with code: $?"
    fi
    
    if wait $failure_pid; then
        echo "Failure process completed successfully"
    else
        echo "Failure process failed with code: $?"
    fi
}

demo_wait

# =============================================================================
# PROCESS SYNCHRONIZATION
# =============================================================================

echo -e "\n=== PROCESS SYNCHRONIZATION ==="

# Demonstrate process synchronization patterns
sync_demo() {
    echo "Process synchronization examples:"
    
    # Producer-Consumer pattern
    echo "1. Producer-Consumer pattern:"
    
    # Create a named pipe for communication
    mkfifo sync_pipe 2>/dev/null || true
    
    # Producer process
    {
        echo "Producer: Starting"
        for i in {1..5}; do
            echo "Data-$i" > sync_pipe
            echo "Producer: Sent Data-$i"
            sleep 0.5
        done
        echo "DONE" > sync_pipe
        echo "Producer: Finished"
    } &
    producer_pid=$!
    
    # Consumer process
    {
        echo "Consumer: Starting"
        while IFS= read -r data; do
            if [[ "$data" == "DONE" ]]; then
                break
            fi
            echo "Consumer: Received $data"
            sleep 0.3
        done < sync_pipe
        echo "Consumer: Finished"
    } &
    consumer_pid=$!
    
    # Wait for both processes
    wait $producer_pid $consumer_pid
    rm -f sync_pipe
    
    echo -e "\n2. Parallel processing with synchronization:"
    
    # Process multiple items in parallel with limited concurrency
    process_items() {
        local max_jobs=3
        local items=("item1" "item2" "item3" "item4" "item5" "item6")
        local pids=()
        
        for item in "${items[@]}"; do
            # Wait if we have too many jobs running
            while [[ ${#pids[@]} -ge $max_jobs ]]; do
                # Check for completed jobs
                local new_pids=()
                for pid in "${pids[@]}"; do
                    if kill -0 "$pid" 2>/dev/null; then
                        new_pids+=("$pid")
                    else
                        wait "$pid"
                        echo "Job $pid completed"
                    fi
                done
                pids=("${new_pids[@]}")
                sleep 0.1
            done
            
            # Start new job
            {
                echo "Processing $item (PID: $$)"
                sleep $((RANDOM % 3 + 1))
                echo "Finished $item"
            } &
            pids+=($!)
            echo "Started job for $item (PID: $!)"
        done
        
        # Wait for all remaining jobs
        for pid in "${pids[@]}"; do
            wait "$pid"
        done
        
        echo "All items processed"
    }
    
    process_items
}

sync_demo

# =============================================================================
# SIGNALS AND TRAPS
# =============================================================================

echo -e "\n=== SIGNALS AND TRAPS ==="

# Demonstrate signal handling with trap
signal_demo() {
    echo "Signal handling demonstration:"
    
    # Set up signal handlers
    cleanup() {
        echo "Cleanup function called"
        # Clean up temporary files, kill child processes, etc.
        jobs -p | xargs -r kill 2>/dev/null || true
        rm -f temp_signal_file
        echo "Cleanup completed"
    }
    
    handle_interrupt() {
        echo "Interrupt signal received (Ctrl+C)"
        cleanup
        exit 130
    }
    
    handle_terminate() {
        echo "Terminate signal received"
        cleanup
        exit 143
    }
    
    handle_usr1() {
        echo "USR1 signal received - toggling debug mode"
        if [[ "${DEBUG:-false}" == "true" ]]; then
            DEBUG=false
            echo "Debug mode OFF"
        else
            DEBUG=true
            echo "Debug mode ON"
        fi
    }
    
    # Set up traps
    trap cleanup EXIT
    trap handle_interrupt INT
    trap handle_terminate TERM
    trap handle_usr1 USR1
    
    echo "Signal handlers installed"
    echo "Current process PID: $$"
    
    # Create a temporary file to demonstrate cleanup
    touch temp_signal_file
    
    # Simulate work that can be interrupted
    echo "Starting interruptible work..."
    for i in {1..10}; do
        echo "Working... step $i/10 (send SIGUSR1 to $$ to toggle debug)"
        [[ "${DEBUG:-false}" == "true" ]] && echo "DEBUG: Step $i details"
        
        # Check if we should continue
        sleep 1
    done
    
    echo "Work completed normally"
}

# Run signal demo in a subshell to contain the traps
(signal_demo) &
signal_demo_pid=$!

# Give it time to start
sleep 2

# Send USR1 signal to demonstrate custom signal handling
echo "Sending USR1 signal to process $signal_demo_pid"
kill -USR1 $signal_demo_pid 2>/dev/null || true

# Wait for the demo to complete
wait $signal_demo_pid 2>/dev/null || true

# =============================================================================
# ADVANCED TRAP USAGE
# =============================================================================

echo -e "\n=== ADVANCED TRAP USAGE ==="

# Demonstrate advanced trap patterns
advanced_trap_demo() {
    echo "Advanced trap usage:"
    
    # Stack-based trap handling
    declare -a trap_stack
    
    push_trap() {
        local signal="$1"
        local command="$2"
        
        # Save current trap
        local current_trap=$(trap -p "$signal" | sed "s/trap -- '\(.*\)' $signal/\1/")
        trap_stack+=("$signal:$current_trap")
        
        # Set new trap
        trap "$command" "$signal"
        echo "Pushed trap for $signal: $command"
    }
    
    pop_trap() {
        local signal="$1"
        
        # Find and restore previous trap
        for i in $(seq $((${#trap_stack[@]} - 1)) -1 0); do
            local entry="${trap_stack[i]}"
            if [[ "$entry" =~ ^$signal: ]]; then
                local previous_trap="${entry#*:}"
                unset trap_stack[i]
                
                if [[ -n "$previous_trap" ]]; then
                    trap "$previous_trap" "$signal"
                    echo "Restored previous trap for $signal"
                else
                    trap - "$signal"
                    echo "Removed trap for $signal"
                fi
                return
            fi
        done
        
        echo "No previous trap found for $signal"
    }
    
    # Demonstrate nested trap handling
    echo "Setting up nested traps:"
    
    push_trap EXIT "echo 'Outer cleanup'"
    push_trap EXIT "echo 'Inner cleanup'; pop_trap EXIT"
    
    # Timeout trap
    timeout_handler() {
        echo "Operation timed out!"
        exit 124
    }
    
    with_timeout() {
        local timeout="$1"
        shift
        
        # Set up timeout
        (
            sleep "$timeout"
            echo "Timeout reached, sending ALRM signal to $$"
            kill -ALRM $$ 2>/dev/null || true
        ) &
        local timeout_pid=$!
        
        push_trap ALRM timeout_handler
        
        # Execute command
        "$@"
        local result=$?
        
        # Cancel timeout
        kill $timeout_pid 2>/dev/null || true
        wait $timeout_pid 2>/dev/null || true
        pop_trap ALRM
        
        return $result
    }
    
    # Test timeout (this will complete before timeout)
    echo "Testing operation with timeout:"
    with_timeout 3 bash -c 'echo "Quick operation"; sleep 1; echo "Completed"'
    
    echo "Advanced trap demo completed"
}

advanced_trap_demo

# =============================================================================
# CHECKING RUNNING PROCESSES
# =============================================================================

echo -e "\n=== CHECKING RUNNING PROCESSES ==="

# Demonstrate process checking
process_check_demo() {
    echo "Process checking demonstration:"
    
    # Start some test processes
    echo "Starting test processes..."
    
    # Long-running background process
    {
        echo "Test process 1 starting"
        for i in {1..20}; do
            echo "Test process 1: iteration $i"
            sleep 0.5
        done
    } &
    test_pid1=$!
    
    # Another test process
    {
        echo "Test process 2 starting"
        sleep 5
        echo "Test process 2 finished"
    } &
    test_pid2=$!
    
    echo "Started test processes: $test_pid1, $test_pid2"
    
    # Basic ps usage
    echo -e "\nBasic ps commands:"
    echo "Current user processes:"
    ps -u "$USER" -o pid,ppid,cmd | head -10
    
    echo -e "\nProcesses with specific pattern:"
    ps aux | grep -E "(bash|sleep)" | grep -v grep | head -5
    
    # Using pgrep and pkill
    echo -e "\nUsing pgrep:"
    if command -v pgrep >/dev/null 2>&1; then
        echo "Bash processes:"
        pgrep -l bash | head -5
        
        echo "Processes by current user:"
        pgrep -u "$USER" -l | head -5
    else
        echo "pgrep not available"
    fi
    
    # Process information functions
    get_process_info() {
        local pid="$1"
        
        if [[ ! -d "/proc/$pid" ]]; then
            echo "Process $pid not found"
            return 1
        fi
        
        echo "Process information for PID $pid:"
        echo "  Command: $(cat /proc/$pid/comm 2>/dev/null || echo 'N/A')"
        echo "  Status: $(awk '/^State:/ {print $2, $3}' /proc/$pid/status 2>/dev/null || echo 'N/A')"
        echo "  Parent PID: $(awk '/^PPid:/ {print $2}' /proc/$pid/status 2>/dev/null || echo 'N/A')"
        echo "  Memory: $(awk '/^VmRSS:/ {print $2, $3}' /proc/$pid/status 2>/dev/null || echo 'N/A')"
    }
    
    # Check our test processes
    echo -e "\nDetailed process information:"
    get_process_info $test_pid1
    echo
    get_process_info $test_pid2
    
    # Process monitoring
    monitor_process() {
        local pid="$1"
        local duration="${2:-5}"
        
        echo "Monitoring process $pid for $duration seconds:"
        
        for i in $(seq 1 "$duration"); do
            if kill -0 "$pid" 2>/dev/null; then
                local cpu_time=$(ps -o cputime= -p "$pid" 2>/dev/null | tr -d ' ')
                local mem_usage=$(ps -o rss= -p "$pid" 2>/dev/null | tr -d ' ')
                echo "  [$i] PID $pid - CPU: ${cpu_time:-N/A}, Memory: ${mem_usage:-N/A}KB"
            else
                echo "  [$i] Process $pid has terminated"
                break
            fi
            sleep 1
        done
    }
    
    echo -e "\nMonitoring test process:"
    monitor_process $test_pid1 3
    
    # Clean up test processes
    echo -e "\nCleaning up test processes..."
    kill $test_pid1 $test_pid2 2>/dev/null || true
    wait $test_pid1 $test_pid2 2>/dev/null || true
    echo "Test processes terminated"
}

process_check_demo

# =============================================================================
# PROCESS CONTROL FUNCTIONS
# =============================================================================

echo -e "\n=== PROCESS CONTROL FUNCTIONS ==="

# Advanced process management functions
process_control_demo() {
    echo "Advanced process control:"
    
    # Function to safely kill a process
    safe_kill() {
        local pid="$1"
        local timeout="${2:-10}"
        
        if ! kill -0 "$pid" 2>/dev/null; then
            echo "Process $pid is not running"
            return 0
        fi
        
        echo "Attempting to terminate process $pid gracefully..."
        kill -TERM "$pid" 2>/dev/null || return 1
        
        # Wait for graceful termination
        for i in $(seq 1 "$timeout"); do
            if ! kill -0 "$pid" 2>/dev/null; then
                echo "Process $pid terminated gracefully"
                return 0
            fi
            sleep 1
        done
        
        echo "Process $pid did not terminate gracefully, forcing..."
        kill -KILL "$pid" 2>/dev/null || return 1
        
        # Wait a bit more
        sleep 1
        if ! kill -0 "$pid" 2>/dev/null; then
            echo "Process $pid forcefully terminated"
            return 0
        else
            echo "Failed to terminate process $pid"
            return 1
        fi
    }
    
    # Function to wait for a process to start
    wait_for_process() {
        local process_name="$1"
        local timeout="${2:-30}"
        
        echo "Waiting for process '$process_name' to start..."
        
        for i in $(seq 1 "$timeout"); do
            if pgrep -f "$process_name" >/dev/null 2>&1; then
                local pid=$(pgrep -f "$process_name" | head -1)
                echo "Process '$process_name' started with PID $pid"
                return 0
            fi
            sleep 1
        done
        
        echo "Process '$process_name' did not start within $timeout seconds"
        return 1
    }
    
    # Function to restart a process
    restart_process() {
        local process_name="$1"
        local start_command="$2"
        
        echo "Restarting process: $process_name"
        
        # Find and stop existing process
        local existing_pid=$(pgrep -f "$process_name" | head -1)
        if [[ -n "$existing_pid" ]]; then
            echo "Stopping existing process $existing_pid"
            safe_kill "$existing_pid"
        fi
        
        # Start new process
        echo "Starting new process: $start_command"
        eval "$start_command" &
        local new_pid=$!
        
        # Verify it started
        sleep 1
        if kill -0 "$new_pid" 2>/dev/null; then
            echo "Process restarted successfully with PID $new_pid"
            return 0
        else
            echo "Failed to restart process"
            return 1
        fi
    }
    
    # Test the functions
    echo "Testing process control functions:"
    
    # Start a test process
    {
        echo "Long-running test process starting"
        trap 'echo "Test process received TERM signal, exiting gracefully"; exit 0' TERM
        for i in {1..30}; do
            echo "Test process: iteration $i"
            sleep 1
        done
    } &
    test_control_pid=$!
    
    echo "Started test process with PID $test_control_pid"
    sleep 2
    
    # Test safe kill
    safe_kill $test_control_pid
    
    echo "Process control demo completed"
}

process_control_demo

# =============================================================================
# JOB QUEUE MANAGEMENT
# =============================================================================

echo -e "\n=== JOB QUEUE MANAGEMENT ==="

# Implement a simple job queue
job_queue_demo() {
    echo "Job queue management system:"
    
    # Job queue implementation
    declare -a job_queue
    declare -a running_jobs
    max_concurrent_jobs=2
    
    add_job() {
        local job_command="$1"
        job_queue+=("$job_command")
        echo "Added job to queue: $job_command"
    }
    
    start_next_job() {
        if [[ ${#job_queue[@]} -eq 0 ]]; then
            return 1
        fi
        
        local job_command="${job_queue[0]}"
        # Remove first element from queue
        job_queue=("${job_queue[@]:1}")
        
        # Start the job
        eval "$job_command" &
        local job_pid=$!
        running_jobs+=("$job_pid")
        
        echo "Started job: $job_command (PID: $job_pid)"
        return 0
    }
    
    cleanup_finished_jobs() {
        local new_running_jobs=()
        
        for pid in "${running_jobs[@]}"; do
            if kill -0 "$pid" 2>/dev/null; then
                new_running_jobs+=("$pid")
            else
                wait "$pid" 2>/dev/null || true
                echo "Job completed: PID $pid"
            fi
        done
        
        running_jobs=("${new_running_jobs[@]}")
    }
    
    process_job_queue() {
        echo "Processing job queue..."
        
        while [[ ${#job_queue[@]} -gt 0 ]] || [[ ${#running_jobs[@]} -gt 0 ]]; do
            # Clean up finished jobs
            cleanup_finished_jobs
            
            # Start new jobs if we have capacity
            while [[ ${#running_jobs[@]} -lt $max_concurrent_jobs ]] && [[ ${#job_queue[@]} -gt 0 ]]; do
                start_next_job
            done
            
            # Show status
            echo "Queue: ${#job_queue[@]} jobs, Running: ${#running_jobs[@]} jobs"
            
            sleep 1
        done
        
        echo "All jobs completed"
    }
    
    # Add some test jobs
    add_job "echo 'Job 1 starting'; sleep 3; echo 'Job 1 finished'"
    add_job "echo 'Job 2 starting'; sleep 2; echo 'Job 2 finished'"
    add_job "echo 'Job 3 starting'; sleep 4; echo 'Job 3 finished'"
    add_job "echo 'Job 4 starting'; sleep 1; echo 'Job 4 finished'"
    add_job "echo 'Job 5 starting'; sleep 2; echo 'Job 5 finished'"
    
    # Process the queue
    process_job_queue
}

job_queue_demo

# =============================================================================
# PROCESS MONITORING AND HEALTH CHECKS
# =============================================================================

echo -e "\n=== PROCESS MONITORING ==="

# Process health monitoring
health_monitor_demo() {
    echo "Process health monitoring:"
    
    # Health check function
    health_check() {
        local process_name="$1"
        local max_memory_mb="${2:-100}"
        local max_cpu_percent="${3:-80}"
        
        local pid=$(pgrep -f "$process_name" | head -1)
        
        if [[ -z "$pid" ]]; then
            echo "CRITICAL: Process '$process_name' not running"
            return 2
        fi
        
        # Check memory usage
        local memory_kb=$(ps -o rss= -p "$pid" 2>/dev/null | tr -d ' ')
        local memory_mb=$((memory_kb / 1024))
        
        # Check CPU usage (simplified)
        local cpu_percent=$(ps -o pcpu= -p "$pid" 2>/dev/null | tr -d ' ' | cut -d. -f1)
        
        echo "Process '$process_name' (PID: $pid):"
        echo "  Memory: ${memory_mb}MB (limit: ${max_memory_mb}MB)"
        echo "  CPU: ${cpu_percent}% (limit: ${max_cpu_percent}%)"
        
        local status="OK"
        local exit_code=0
        
        if [[ $memory_mb -gt $max_memory_mb ]]; then
            echo "  WARNING: Memory usage exceeds limit"
            status="WARNING"
            exit_code=1
        fi
        
        if [[ ${cpu_percent:-0} -gt $max_cpu_percent ]]; then
            echo "  WARNING: CPU usage exceeds limit"
            status="WARNING"
            exit_code=1
        fi
        
        echo "  Status: $status"
        return $exit_code
    }
    
    # Start a test process to monitor
    {
        echo "Monitored process starting"
        # Simulate some work
        for i in {1..10}; do
            echo "Monitored process: working $i/10"
            sleep 1
        done
        echo "Monitored process finished"
    } &
    monitored_pid=$!
    
    echo "Started monitored process with PID $monitored_pid"
    sleep 1
    
    # Monitor the process
    echo "Performing health checks:"
    for i in {1..3}; do
        echo "Health check $i:"
        health_check "Monitored process" 50 50
        echo
        sleep 2
    done
    
    # Clean up
    kill $monitored_pid 2>/dev/null || true
    wait $monitored_pid 2>/dev/null || true
}

health_monitor_demo

# =============================================================================
# CLEANUP AND SUMMARY
# =============================================================================

echo -e "\n=== CLEANUP ==="

# Kill any remaining background processes
jobs -p | xargs -r kill 2>/dev/null || true

# Wait for cleanup
sleep 1

echo -e "\n=== PROCESS MANAGEMENT SUMMARY ==="
echo "✓ Background and foreground jobs (&, jobs)"
echo "✓ Wait command for process synchronization"
echo "✓ Signals and traps (trap command)"
echo "✓ Process checking (ps, pgrep)"
echo "✓ Advanced signal handling"
echo "✓ Process control functions"
echo "✓ Job queue management"
echo "✓ Process monitoring and health checks"

echo "Script completed successfully!"
