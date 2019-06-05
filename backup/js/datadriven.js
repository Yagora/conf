'use strict';

/**
 * Freely inspired from https://github.com/fluentsoftware/data-driven
 */

function buildTestFn(f, testData) {
	if (f.length < 2) {
		return function () {
			return f.call(this, testData);
		};
	}
	return function (done) {
		return f.call(this, testData, done);
	};
}

function formatValue(value) {
	if (typeof value === 'function') {
		return 'function';
	}
	if (Array.isArray(value)) {
		return `[${value.map(formatValue).join(', ')}]`;
	}
	if (typeof value === 'object') {
		return `${JSON.stringify(value)}`;
	}
	return value;
}

function buildPairs(data) {
	if (!data) {
		return '';
	}
	return Object.keys(data).map(field => `(${field}=${formatValue(data[field])})`).join(' ');
}

function buildTernary(data, ifTrue, ifFalse) {
	if (!data) {
		return ifFalse;
	}
	return ifTrue;
}

function hasOnly(data) {
	return data.some(ctx => ctx.only);
}

module.exports = (data, fn) => {
	const mochaIt = it;
	const mochaBefore = before;
	const filterOnly = hasOnly(data);

	data.forEach(testData => {
		if (!filterOnly || testData.only) {
			try {
				it = function (title, f) { // eslint-disable-line no-native-reassign
					let newTitle = title;

					if (testData.itMsg) {
						newTitle = testData.itMsg;
					} else {
						for (const key in testData) {
							newTitle = newTitle.replace(`{${key}}`, formatValue(testData[key]));
							newTitle = newTitle.replace(`{keys:${key}}`, Object.keys(testData[key] || []).join(', '));
							newTitle = newTitle.replace(`{pairs:${key}}`, buildPairs(testData[key]));
							const ternaryExp = new RegExp(`\\{${key}\\s?\\?\\s?"([^"]*)"\\s?:\\s?"([^"]*)"\\}`);
							if (ternaryExp.test(newTitle)) {
								const ifTrue = ternaryExp.exec(newTitle)[1];
								const ifFalse = ternaryExp.exec(newTitle)[2];
								newTitle = newTitle.replace(ternaryExp, buildTernary(testData[key], ifTrue, ifFalse));
							}
						}
					}
					newTitle = newTitle.replace('{context}', buildPairs(testData));

					let testFn;
					if (f !== undefined) {
						testFn = buildTestFn(f, testData);
					}

					if (testData.skip) {
						mochaIt(newTitle);
					} else {
						mochaIt(newTitle, testFn);
					}
				};
				before = function (f) { // eslint-disable-line no-native-reassign
					mochaBefore(buildTestFn(f, testData));
				};

				fn(testData);
			} finally {
				it = mochaIt; // eslint-disable-line no-native-reassign
				before = mochaBefore; // eslint-disable-line no-native-reassign
			}
		}
	});
};
