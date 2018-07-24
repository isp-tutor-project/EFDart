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



/**
 *  The shared DB connection for a given isolate. (implemented as Singleton)
 *
 */
class sharedDB
{
  Db       Database;

  static final sharedDB _Singleton = new sharedDB._internal();

  factory sharedDB()
  {
    return _Singleton;
  }

  sharedDB._internal()
  {
    if(GDSharedDB) print("sharedDB created:");
  }

  // Attempt to gain access to a DB on this shared object.

  Future access(String name)
  {
    Future    openWatcher;
    Completer openCompleter;

    var URI = "mongodb://127.0.0.1/" + name;

    // If the shared connection exists we need to check if it is the same DB as what we are
    // asking for in this call

    if(Database != null)
    {
      // If we are currently connected to a different DB - close it and then open the new one.

      if(Database.databaseName != name)
      {
        if(GDSharedDB) print("sharedDB switching to: $URI");

        Database.close();

        Database = new Db(URI);

        openWatcher = Database.open(writeConcern: WriteConcern.ACKNOWLEDGED );
      }

      // Otherwise we create a completer to get a Future that completes immediately with
      // true to indicate we are ready to go.

      else
      {
        if(GDSharedDB) print("sharedDB accessing current: $URI");

        openCompleter = new Completer();
        openCompleter.complete(true);

        openWatcher = openCompleter.future;
      }
    }
    // Create a new connection and attempt to open it.
    else
    {
      if(GDSharedDB) print("sharedDB accessing new: $URI");

      Database = new Db(URI);

      openWatcher = Database.open(writeConcern: WriteConcern.ACKNOWLEDGED );
    }

    return openWatcher;
  }

  Future dbCommand(Map command)
  {
    return Database.executeDbCommand(DbCommand.createQueryDbCommand(Database,command));
  }

  collection(String collectionName)
  {
    return Database.collection(collectionName);
  }

}