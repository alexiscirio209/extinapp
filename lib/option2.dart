import 'package:flutter/material.dart';

class ObservacionFormPage extends StatefulWidget {
  final Map<String, dynamic> extintor;

  const ObservacionFormPage({super.key, required this.extintor});

  @override
  State<ObservacionFormPage> createState() => _ObservacionFormPageState();
}

class _ObservacionFormPageState extends State<ObservacionFormPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _observacionController;

  @override
  void initState() {
    super.initState();
    _observacionController = TextEditingController(text: widget.extintor['observacion']);
  }

  @override
  void dispose() {
    _observacionController.dispose();
    super.dispose();
  }

  void _guardarObservacion() {
    if (_formKey.currentState!.validate()) {
      final nuevaObservacion = _observacionController.text;
      final fechaActual = DateTime.now().toIso8601String().split('T').first;

      final actualizado = {
        ...widget.extintor,
        'observacion': nuevaObservacion,
        'fecha': fechaActual,
        'inspeccionado': true,
      };

      Navigator.pop(context, actualizado);
    }
  }

  @override
  Widget build(BuildContext context) {
    final extintor = widget.extintor;

    return Scaffold(
      appBar: AppBar(title: Text('Observación - ${extintor['id']}')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Ubicación: ${extintor['ubicacion']}', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 20),
              TextFormField(
                controller: _observacionController,
                decoration: const InputDecoration(
                  labelText: 'Observación',
                  border: OutlineInputBorder(),
                ),
                maxLines: 4,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Por favor ingresa una observación';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.save),
                  label: const Text('Guardar'),
                  onPressed: _guardarObservacion,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}