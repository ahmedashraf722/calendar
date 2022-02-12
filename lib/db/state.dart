abstract class DbStates {}

class AppInitialState extends DbStates {}

class AppCreateDatabaseState extends DbStates {}

class AppInsertDatabaseState extends DbStates {}

class AppGetDataFromDatabaseLoadingState extends DbStates {}

class AppGetDataFromDatabaseState extends DbStates {}

class AppUpdateDatabaseState extends DbStates {}

class AppChangeCompleteDatabaseState extends DbStates {}

class AppDeleteDataFromDatabaseState extends DbStates {}
