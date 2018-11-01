#-------------------------------------------------------------------------------
# Copyright 2017 Cognizant Technology Solutions
#   
# Licensed under the Apache License, Version 2.0 (the "License"); you may not
# use this file except in compliance with the License.  You may obtain a copy
# of the License at
# 
#   http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the
# License for the specific language governing permissions and limitations under
# the License.
#-------------------------------------------------------------------------------
#! /bin/sh
# /etc/init.d/InSightsVSTSCIAgent

### BEGIN INIT INFO
# Provides: Runs a Python script on startup
# Required-Start: BootPython start
# Required-Stop: BootPython stop
# Default-Start: 2 3 4 5
# Default-stop: 0 1 6
# Short-Description: Simple script to run python program at boot
# Description: Runs a python program at boot
### END INIT INFO
#export INSIGHTS_AGENT_HOME=/home/ec2-user/insightsagents
source /etc/profile

case "$1" in
  start)
    if [[ $(ps aux | grep '[c]i.vstsci.VSTSCIAgent' | awk '{print $2}') ]]; then
     echo "InSightsVSTSCIAgent already running"
    else
     echo "Starting InSightsVSTSCIAgent"
     cd $INSIGHTS_AGENT_HOME/PlatformAgents/vstsci
     python -c "from com.cognizant.devops.platformagents.agents.ci.vstsci.VSTSCIAgent import VSTSCIAgent; VSTSCIAgent()" &
    fi
    if [[ $(ps aux | grep '[c]i.vstsci.VSTSCIAgent' | awk '{print $2}') ]]; then
     echo "InSightsVSTSCIAgent Started Sucessfully"
    else
     echo "InSightsVSTSCIAgent Failed to Start"
    fi
    ;;
  stop)
    echo "Stopping InSightsVSTSCIAgent"
    if [[ $(ps aux | grep '[c]i.vstsci.VSTSCIAgent' | awk '{print $2}') ]]; then
     sudo kill -9 $(ps aux | grep '[c]i.vstsci.VSTSCIAgent' | awk '{print $2}')
    else
     echo "InSIghtsVSTSCIAgent already in stopped state"
    fi
    if [[ $(ps aux | grep '[c]i.vstsci.VSTSCIAgent' | awk '{print $2}') ]]; then
     echo "InSightsVSTSCIAgent Failed to Stop"
    else
     echo "InSightsVSTSCIAgent Stopped"
    fi
    ;;
  restart)
    echo "Restarting InSightsVSTSCIAgent"
    if [[ $(ps aux | grep '[c]i.vstsci.VSTSCIAgent' | awk '{print $2}') ]]; then
     echo "InSightsVSTSCIAgent stopping"
     sudo kill -9 $(ps aux | grep '[c]i.vstsci.VSTSCIAgent' | awk '{print $2}')
     echo "InSightsVSTSCIAgent stopped"
     echo "InSightsVSTSCIAgent starting"
     cd $INSIGHTS_AGENT_HOME/PlatformAgents/vstsci
     python -c "from com.cognizant.devops.platformagents.agents.ci.vstsci.VSTSCIAgent import VSTSCIAgent; VSTSCIAgent()" &
     echo "InSightsVSTSCIAgent started"
    else
     echo "InSightsVSTSCIAgent already in stopped state"
     echo "InSightsVSTSCIAgent starting"
     cd $INSIGHTS_AGENT_HOME/PlatformAgents/vstsci
     python -c "from com.cognizant.devops.platformagents.agents.ci.vstsci.VSTSCIAgent import VSTSCIAgent; VSTSCIAgent()" &
     echo "InSightsVSTSCIAgent started"
    fi
    ;;
  status)
    echo "Checking the Status of InSightsVSTSCIAgent"
    if [[ $(ps aux | grep '[c]i.vstsci.VSTSCIAgent' | awk '{print $2}') ]]; then
     echo "InSightsVSTSCIAgent is running"
    else
     echo "InSightsVSTSCIAgent is stopped"
    fi
    ;;
  *)
    echo "Usage: /etc/init.d/InSightsVSTSCIAgent {start|stop|restart|status}"
    exit 1
    ;;
esac
exit 0
