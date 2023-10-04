import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:total_pos_waiter/models/ticket.dart';
import 'package:total_pos_waiter/models/settings.dart';

class TicketService {
  Future<List<Ticket>> getTickets(String jwt) async {
    try {
      final response = await http.get(Uri.http(Settings.serverHost, '/tickets'),
          headers: {'Authorization': 'Bearer $jwt'});
      final jsonList = jsonDecode(response.body) as List<dynamic>;
      return jsonList.map((json) => Ticket.fromJson(json)).toList();
    } catch (e) {
      log('Error: Class TicketService => Method getTickets');
      log(e.toString());
      return [];
    }
  }

  Future<Ticket> getTicketByID(String jwt, int ticketId) async {
    try {
      final response = await http.get(
          Uri.http(Settings.serverHost, '/tickets/$ticketId'),
          headers: {'Authorization': 'Bearer $jwt'});
      final jsonTicket = jsonDecode(response.body);
      return Ticket.fromJson(jsonTicket);
    } catch (e) {
      log('Error: Class TicketService => Method getTicketByID');
      log(e.toString());
      throw 'getTicketByID';
    }
  }

  Future<Ticket> createTicket(String jwt) async {
    try {
      final response = await http.post(
          Uri.http(Settings.serverHost, '/tickets'),
          headers: {'Authorization': 'Bearer $jwt'});
      final jsonTicket = jsonDecode(response.body);
      return Ticket.fromJson(jsonTicket);
    } catch (e) {
      log('Error: Class TicketService => Method createTicket');
      log(e.toString());
      throw 'createTicket';
    }
  }

  Future<bool> deleteTicket(String jwt, int ticketId) async {
    try {
      final response = await http.delete(
          Uri.http(Settings.serverHost, '/tickets/$ticketId'),
          headers: {'Authorization': 'Bearer $jwt'});
      return response.statusCode == 200;
    } catch (e) {
      log('Error: Class TicketService => Method deleteTicket');
      log(e.toString());
      return false;
    }
  }

  Future<Ticket> addProductToTicket(
      String jwt, int ticketId, int productId) async {
    try {
      final response = await http.post(
          Uri.http(
              Settings.serverHost, '/tickets/$ticketId/products/$productId'),
          headers: {'Authorization': 'Bearer $jwt'});
      final jsonList = jsonDecode(response.body);
      return Ticket.fromJson(jsonList);
    } catch (e) {
      log('Error: Class TicketService => Method addProductToTicket');
      log(e.toString());
      throw 'addProductToTicket';
    }
  }

  Future<Ticket> deleteProductToTicket(
      String jwt, int ticketId, int productId) async {
    try {
      final response = await http.delete(
          Uri.http(
              Settings.serverHost, '/tickets/$ticketId/products/$productId'),
          headers: {'Authorization': 'Bearer $jwt'});
      final jsonList = jsonDecode(response.body);
      return Ticket.fromJson(jsonList);
    } catch (e) {
      log('Error: Class TicketService => Method deleteProductToTicket');
      log(e.toString());
      throw 'deleteProductToTicket';
    }
  }
}
