**Will use this repo for developing SNMP checks for Broadworks**
Check-uri de dezvoltat:
1. AS
2. MS
3. NS
4. XPS
5. PS
6. NFM


Check-uri per tip de server:
1. AS
    - Database Size
    - Execution Server Heap Size
    - Maximum post-collection heap size
    - DAtabase (DCS) utilization
    - NbCallAttempts
    - bwCallpCallsPerSecond
    - bwCallpActiveCalls
    - SIP Messages Per Second
    - OCI Provisioning Transactions Per Second
    - SystemInternalQueueTimeAvg
    - SystemInternalQueueTimeMax
    - bwSipStatsSetupSignalDelay
    - bwSipStatsAnswerSignalDelay

2. NS
    - Database Size
    - Execution Server Heap Size  
    - Database (DSN) utilization
    - bwNSCallpCallsPerSecond
    - SystemInternalQueueTimeAvg
    - SystemInternalQueueTimeMax

3. MS
    - msPortsInUse
    - msNoPortAvailableErrors


Descrieri pentru cele de mai sus:

AS/NS
Database Size
See “10.2.1.2 Database Permanent Size” of System Engineering Guide
Daily
DB PermSize_In_Use  ≤ 90%
Database can be resized up to the maximum supported database size of 6 GB (with 16 GB of physical memory).
 
AS/NS
Execution Server
Heap Size
See 10.2.1.1 “Execution Server Post Full Collection Heap Size” of System Engineering Guide
Daily
Post Full Garbage Collection Heap size ≤ 60% of Maximum Heap
Execution Server process heap size can be resized up to the maximum supported heap size of 4 GB (with 16 GB of physical memory).
 
AS
Maximum post-collection heap size
See 10.2.1.1 “Execution Server Post Full Collection Heap Size” of System Engineering Guide
Daily
  Yellow: 60
Red: 68
Provides the percentage of the memory consumption of the Java Virtual Machine (JVM) following a full Garbage Collection (GC). Initially, the statistic value is set to “0”. Henceforth, the statistic value is set from the value of the previous day.
 
 
AS/NS
Database (DSN) utilization
NA
Daily
Yellow: 85
Red: 90
Indicates the percentage of the database size currently used by the application.
 
MS
msPortsInUse
.1.3.6.1.4.1.6431.1.3.1.1.0
15 minutes
NA
Trend port usage as a percentage of available Media Server ports.
 
MS
msNoPortAvailableErrors
.1.3.6.1.4.1.6431.1.3.1.6.0
30 minutes
0, for 0% blocking per Media Server
Ideally zero, unless Media Server blocking is acceptable.
 
NS
bwNSCallpCallsPerSecond
.1.3.6.1.4.1.6431.1.5.2.6
15 minutes
Small: < 150
Medium: < 300
Large: < 600
For information on small, medium, and large hardware configuration, see the BroadWorks System Engineering Guide and BroadWorks Recommended Hardware Guide.
 
AS
bwNumberOfUsers
.1.3.6.1.4.1.16431.1.2.16.1.2.0
Weekly
Not Applicable
Trend user growth as each Application Server cluster.
 
AS
NbCallAttempts
.1.3.6.1.4.1.6431.1.2.7.1.4.0   + .1.3.6.1.4.1.6431.1.2.7.1.1.0
15 minutes
Not applicable
Used to identify server peak busy hour by multiplying maximum reading by 4.
 
AS
bwCallpCallsPerSecond
.1.3.6.1.4.1.6431.1.2.7.1.12.0
15 minutes
Small: < 11
Medium: < 33
Large: < 55
Trend call per second on each Application Server cluster.
 
AS
bwCallpActiveCalls
.1.3.6.1.4.1.6431.1.2.7.1.10.0
15 minutes
Not applicable
Trend number of active calls on each Application Server cluster.
 
AS
SIP Messages Per Second
(.1.3.6.1.4.1.6431.1.2.9.1.55.0+.1.3.6.1.4.1.6431.1.2.9.1.56.0
+
.1.3.6.1.4.1.6431.1.2.9.1.58.0+.1.3.6.1.4.1.6431.1.2.9.1.59.0)
/$DELTA_TIME
15 minutes
Small: < 200
Medium: < 600
Large: < 1000
Sum of all TCP and UDP SIP requests/responses and MGCP requests/responses. For information on small, medium, and large hardware configuration, see the BroadWorks System Engineering Guide and BroadWorks Recommended Hardware Guide.
 
AS
OCI Provisioning Transactions Per Second
(.1.3.6.1.4.1.6431.1.6.8.1.1.0
+
.1.3.6.1.4.1.6431.1.6.8.1.3.0+.1.3.6.1.4.1.6431.1.6.8.1.5.0)
/$DELTA_TIME
15 minutes
Small: < 11
Medium: < 30
Large: < 50
 
Sum of all OCI provisioning requests/responses. For information on small, medium, and large hardware configuration, see the BroadWorks System Engineering Guide and BroadWorks Recommended Hardware Guide.
 
AS/NS
SystemInternalQueueTimeAvg
.1.3.6.1.4.1.6431.1.2.16.2.2.1.4.0
15 minutes
≤ 25 msec
All primary queues should have average queue wait times less than or equal to 25 milliseconds.
 
AS/NS
SystemInternalQueueTimeMax
.1.3.6.1.4.1.6431.1.2.16.2.2.1.6.0
15 minutes
Maximum Time Distribution
80%: ≤ 500 msec
95%: ≤ 1.5 sec
100%: ≤ 2.5 sec
0%: >2.5 sec
All primary queues should have high water mark distribution within the following ranges. No high water mark should ever be greater than 2.5 seconds.
 
AS
bwSipStatsSetupSignalDelay
.1.3.6.1.4.1.6431.1.2.9.1.44.0
15 minutes
≤ 200 msec
Time in milliseconds from the receipt of an INVITE message for the origination of a new call and the transmission of an INVITE to the terminator. Commonly referred to as cross-office signaling delay.
Should be polled and reset.
 
AS
bwSipStatsAnswerSignalDelay
.1.3.6.1.4.1.6431.1.2.9.1.47.0
15 minutes
≤ 200 msec
Time in milliseconds between the receipt of a 200 OK message, indicating answer and the transmission of a 200 OK, indicating answer to the originator.
Should be polled and reset