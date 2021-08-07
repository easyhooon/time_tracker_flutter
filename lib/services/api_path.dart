class APIPath {
  //for write
  static String job(String uid, String jobId) => '/users/$uid/jobs/$jobId';

  //for read
  static String jobs(String uid) => '/users/$uid/jobs';

  // static String entry(String uid, String jobId, String entryId) =>
  //     'users/$uid/jobs/$jobId/entries/$entryId';
  //
  // static String entries(String uid, String jobId) =>
  //     'users/$uid/jobs/$jobId/entries';

  static String entry(String uid, String entryId) =>
      '/users/$uid/entries/$entryId';

  static String entries(String uid) => '/users/$uid/entries';
}
