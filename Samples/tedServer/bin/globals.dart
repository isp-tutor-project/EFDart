//
//  The MIT License (MIT)
//
//  Copyright (c) 2013 Kevin Willows
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

part of tedServer;

// Library Global shared DB object instance - This persists within the isolate.

SendPort _GIsolatePoolPort;

// Library Global - Isolate local shared DB connection - (implemented as Singleton)

sharedDB _GSharedDB;

// Global Debug Flags

bool GDConnectionCounter = false;      // debug connection counter
bool GDPolicyProtocol    = false;      // debug cross domain policy requests
bool GDProtocol          = false;      // debug the Admin protocol
bool GSTProtocol         = false;      // debug the Guest protocol
bool GDAuthProtocol      = false;      // debug the protocolAuth
bool GDLogProtocol       = false;      // debug the protocolStudyLgr
bool GDIPoolTimer        = false;      // debug the isolatePoolMonitor time on task
bool GDIPool             = false;      // debug the isolatePoolMonitor
bool GDSocketWorker      = false;      // debug the SocketWorker

bool GDSocketMonitor     = false;      // debug general socketMonitor
bool GDlogStream         = false;      // debug socketMonitor Log events

bool GDWorkerIsolate     = false;      // debug general workerIsolate

bool GDSharedDB          = false;      // debug general sharedDB