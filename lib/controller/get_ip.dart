import 'dart:io';

Future<InternetAddress> getCurrentIPv4Address() async {
  for (var interface in await NetworkInterface.list()) {
    for (var address in interface.addresses) {
      // Check if the address is IPv4 and not a loopback address
      // if (address.type == InternetAddressType.IPv4 && !address.isLoopback) {
      //   return address;
      // }
      if (address.type == InternetAddressType.IPv4 && !address.isLoopback) {
        return address;
      }
    }
  }
  throw Exception('Failed to get current IPv4 address.');
}
