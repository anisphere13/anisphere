# -*- coding: utf-8 -*-
"""Simple training pipeline for AniSphere.

This script loads local training data, trains a TensorFlow model,
exports it as a TFLite file and prepares an archive for deployment
with Firebase Functions.
"""

import argparse
import pathlib
import tensorflow as tf


def train_model(data_dir: pathlib.Path, output_dir: pathlib.Path):
    # Placeholder dataset and model for demonstration purposes
    mnist = tf.keras.datasets.mnist
    (x_train, y_train), _ = mnist.load_data()
    x_train = x_train / 255.0

    model = tf.keras.models.Sequential([
        tf.keras.layers.Flatten(input_shape=(28, 28)),
        tf.keras.layers.Dense(128, activation='relu'),
        tf.keras.layers.Dropout(0.1),
        tf.keras.layers.Dense(10, activation='softmax'),
    ])

    model.compile(optimizer='adam',
                  loss='sparse_categorical_crossentropy',
                  metrics=['accuracy'])

    model.fit(x_train, y_train, epochs=1)

    tflite_model = tf.lite.TFLiteConverter.from_keras_model(model).convert()
    output_dir.mkdir(parents=True, exist_ok=True)
    model_path = output_dir / 'model.tflite'
    with open(model_path, 'wb') as f:
        f.write(tflite_model)

    print(f"Model exported to {model_path}")

    archive = output_dir / 'model_package.zip'
    # create simple archive with the trained model
    import zipfile
    with zipfile.ZipFile(archive, 'w') as zipf:
        zipf.write(model_path, arcname='model.tflite')
    print(f"Package ready: {archive}")


def main():
    parser = argparse.ArgumentParser(description="Train local model and package it")
    parser.add_argument('--data', type=pathlib.Path, default=pathlib.Path('data'))
    parser.add_argument('--out', type=pathlib.Path, default=pathlib.Path('build/model'))
    args = parser.parse_args()
    train_model(args.data, args.out)


if __name__ == '__main__':
    main()
