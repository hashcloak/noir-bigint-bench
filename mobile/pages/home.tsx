/* eslint-disable react-native/no-inline-styles */
import React, {useEffect} from 'react';
import {Text, View} from 'react-native';
import MainLayout from '../layouts/MainLayout';
import Button from '../components/Button';
import {useNavigation} from '@react-navigation/native';
import {prepareSrs} from '../lib/noir';

export default function Home() {
  const navigation = useNavigation();

  useEffect(() => {
    // Load the local SRS (if present in resources) in internal storage
    // Only for Android, will be skipped on iOS
    prepareSrs();
  }, []);

  return (
    <MainLayout>
      <Text
        style={{
          fontSize: 16,
          fontWeight: '500',
          marginBottom: 20,
          textAlign: 'center',
          color: '#6B7280',
        }}>
        Select a benchmark
      </Text>
      <View
        style={{
          gap: 20,
        }}>
        <Button
          onPress={() => {
            navigation.navigate('BenchmarkMult');
          }}>
          <Text
            style={{
              color: 'white',
              fontWeight: '700',
            }}>
            Mult
          </Text>
        </Button>
      </View>
    </MainLayout>
  );
}
