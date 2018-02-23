#!/usr/bin/env python
# -*- coding: utf-8 -*-
__author__ = 'maxim'


from collections import namedtuple, Counter
import numpy as np


Vocab = namedtuple('Vocab', ['token_to_idx', 'idx_to_token'])

def build_vocab(tokens_stream, min_count=0):
  token_to_idx = {}
  idx_to_token = {}
  counter = Counter()
  idx = 0
  for token in tokens_stream:
    if token in token_to_idx:
      continue
    counter[token] += 1
    if counter[token] > min_count:
      token_to_idx[token] = idx
      idx_to_token[idx] = token
      idx += 1
  return Vocab(token_to_idx, idx_to_token)


def encode(text, vocabulary, max_size=None):
  max_size = max_size if max_size is not None else len(text)
  result = np.ones([max_size], dtype=np.int32) * -1   # pad automatically with -1
  for i, token in enumerate(text):
    if i >= max_size:
      break
    idx = vocabulary.token_to_idx.get(token, -1)
    result[i] = idx
  return result, min(len(text), max_size)


def decode(text, length, vocabulary):
  result = []
  for idx in text[:length]:
    result.append(vocabulary.idx_to_token[idx])
  return ''.join(result)