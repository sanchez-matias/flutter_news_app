class Urls {
  static const baseUrl = 'newsapi.org';
  static const apiKey = '8db435518ba84df795b5cda97476bf42';
  static const kGetArticlesEndpoint = '/v2/top-headlines';
  static String articlesByParameters({
    String country = 'us',
    String category = 'general',
  }) =>
      'https://$baseUrl$kGetArticlesEndpoint?apiKey=$apiKey&country=$country&category=$category';
}
