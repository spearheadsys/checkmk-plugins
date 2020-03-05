First of all, you need to create a dummy host, with IP ( localhost) and create the rule
"Individual program call instead of agent access". The value for program call should be:

~/local/share/check_mk/agents/special/pdu_rack_summary.sh

The reason for the rule is that the agent should be run under the check_mk site user.
This special agent takes data for all hosts that containes "pdu" in it and from it's alias
will take the rack information.

It is providing back the information via piggyback mechanism
