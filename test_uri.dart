void main() {
  const url = 'https://accept.paymob.com/api/acceptance/iframes/123?payment_token=abc%2Bdef+ghi=jkl';
  final uri = Uri.parse(url);
  print('Original: $url');
  print('Uri.toString(): $uri');
  print('Uri.queryParameters: ${uri.queryParameters}');
  print('Uri.query: ${uri.query}');
}
