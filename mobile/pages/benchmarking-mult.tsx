/* eslint-disable react-native/no-inline-styles */
import React, { useEffect, useState } from 'react';
import { View, Text, Alert, TouchableOpacity, StyleSheet } from 'react-native';
import MainLayout from '../layouts/MainLayout';
import Button from '../components/Button';
import {
  clearCircuit,
  generateProof,
  setupCircuit,
} from '../lib/noir';
// These circuits contain 100 mults of the respective sizes
import circuitMultU256 from '../circuits/bench_mult_U256/target/bench_mult_U256.json';
import circuitMultU384 from '../circuits/bench_mult_U384/target/bench_mult_U384.json';
import circuitMultU1024 from '../circuits/bench_mult_U1024/target/bench_mult_U1024.json';
import circuitMultU2048 from '../circuits/bench_mult_U2048/target/bench_mult_U2048.json';
import circuitMultU4096 from '../circuits/bench_mult_U4096/target/bench_mult_U4096.json';
import { Circuit } from '../types';

type CircuitName = 'U256' | 'U384' | 'U1024' | 'U2048' | 'U4096';
type ProofType = 'plonk' | 'honk';

interface CircuitResult {
  provingTime: number;
  running: boolean;
}

export default function BenchmarkingMult() {
  const [circuitResults, setCircuitResults] = useState<Record<CircuitName, CircuitResult>>({
    U256: { provingTime: 0, running: false },
    U384: { provingTime: 0, running: false },
    U1024: { provingTime: 0, running: false },
    U2048: { provingTime: 0, running: false },
    U4096: { provingTime: 0, running: false },
  });

  // Default is plonk
  const [proofType, setProofType] = useState<ProofType>('plonk');
  const [benchmarkQueue, setBenchmarkQueue] = useState<CircuitName[]>([]);
  const [isBenchmarking, setIsBenchmarking] = useState(false);

  useEffect(() => {
    if (benchmarkQueue.length > 0 && !isBenchmarking) {
      runNextBenchmark();
    }
  }, [benchmarkQueue, isBenchmarking]);

  const addBenchmarkToQueue = (circuitName: CircuitName) => {
    setBenchmarkQueue((prevQueue) => [...prevQueue, circuitName]);
  };

  // Running too many benchmarks at the same time 
  const runNextBenchmark = async () => {
    if (benchmarkQueue.length === 0) return;

    const circuitName = benchmarkQueue[0];
    setIsBenchmarking(true);
    await runBenchmark(circuitName);
    setBenchmarkQueue((prevQueue) => prevQueue.slice(1)); // Remove the benchmark from the queue
    setIsBenchmarking(false);
  };

  const runBenchmark = async (circuitName: CircuitName) => {
    const circuitJsonMap = {
      U256: circuitMultU256,
      U384: circuitMultU384,
      U1024: circuitMultU1024,
      U2048: circuitMultU2048,
      U4096: circuitMultU4096,
    };

    setCircuitResults((prev) => ({
      ...prev,
      [circuitName]: { provingTime: 0, running: true },
    }));

    try {
      const circuitJson = circuitJsonMap[circuitName];
      const circuitId = await setupCircuit(circuitJson as Circuit);
      const start = performance.now();
      await generateProof(
        { a: 3, b: 4 }, // TODO does this value matter?
        circuitId!,
        proofType
      );
      const end = performance.now();
      // TODO NoirModule also prints a proving time, which might be more accurate
      const provingTime = Math.round(end - start);

      setCircuitResults((prev) => ({
        ...prev,
        [circuitName]: { provingTime, running: false },
      }));

      console.log(`Proving time for ${circuitName}: ${provingTime} ms`);
      clearCircuit(circuitId!);
    } catch (err: any) {
      Alert.alert('Something went wrong', JSON.stringify(err));
      console.error(err);
      setCircuitResults((prev) => ({
        ...prev,
        [circuitName]: { provingTime: 0, running: false },
      }));
    }
  };

  const renderCircuitButton = (circuitName: CircuitName) => (
    <View key={circuitName} style={{ marginBottom: 20 }}>
      <Button
        disabled={isBenchmarking || circuitResults[circuitName].running}
        onPress={() => addBenchmarkToQueue(circuitName)}
      >
        <Text style={{ color: 'white', fontWeight: '700' }}>
          {circuitResults[circuitName].running ? `Running benchmark ${circuitName}...` : `Benchmark ${circuitName}`}
        </Text>
      </Button>
      {circuitResults[circuitName].provingTime > 0 && (
        <Text style={{ textAlign: 'center', color: '#6B7280', marginTop: 10 }}>
          Proving time for {circuitName}: {circuitResults[circuitName].provingTime} ms
        </Text>
      )}
    </View>
  );

  return (
    <MainLayout canGoBack={true}>
      <View style={styles.proofTypeContainer}>
        <TouchableOpacity
          style={[
            styles.proofTypeButton,
            proofType === 'plonk' && styles.proofTypeButtonSelected,
          ]}
          onPress={() => setProofType('plonk')}
        >
          <Text style={[styles.proofTypeText, proofType === 'plonk' && styles.proofTypeTextSelected]}>
            Plonk
          </Text>
        </TouchableOpacity>
        <TouchableOpacity
          style={[
            styles.proofTypeButton,
            proofType === 'honk' && styles.proofTypeButtonSelected,
          ]}
          onPress={() => setProofType('honk')}
        >
          <Text style={[styles.proofTypeText, proofType === 'honk' && styles.proofTypeTextSelected]}>
            Honk
          </Text>
        </TouchableOpacity>
      </View>
      {renderCircuitButton('U256')}
      {renderCircuitButton('U384')}
      {renderCircuitButton('U1024')}
      {renderCircuitButton('U2048')}
      {renderCircuitButton('U4096')}
    </MainLayout>
  );
}

const styles = StyleSheet.create({
  proofTypeContainer: {
    flexDirection: 'row',
    justifyContent: 'center',
    marginBottom: 20,
  },
  proofTypeButton: {
    paddingVertical: 5,
    paddingHorizontal: 15,
    borderRadius: 20,
    borderWidth: 1,
    borderColor: '#151628',
    marginHorizontal: 5,
  },
  proofTypeButtonSelected: {
    backgroundColor: '#151628',
  },
  proofTypeText: {
    color: '#151628',
    fontSize: 14,
    fontWeight: '500',
  },
  proofTypeTextSelected: {
    color: 'white',
  },
  sectionTitle: {
    textAlign: 'center',
    fontWeight: '700',
    color: '#151628',
    fontSize: 16,
    marginBottom: 5,
  },
});
